#include <chrono>
#include <cmath>
#include <iostream>
#include <random>
#include <string>
#include <thread>

//#define accuracy float
#define accuracy double
//#define accuracy long double
#define timeUnit std::chrono::microseconds
#define DEAFULT_BODYCOUNT 1024 << 2
#define DEAFULT_BODYCOUNT_STEP 256
#define DEAFULT_FRAMELIMIT 200
#define DEAFULT_RUNS 10
#define DEAFULT_VERBOSITY 1
#define DEAFULT_ALGO CPUOMP
// must include v this v after ^these macros^
#include "mathsandthings.h"

// globals
enum algo { CPUSEQ, CPUOMP };
algo selectedAlgo = CPUSEQ;
uint8_t verbosity = 0;
size_t bodyCount = 0;
size_t frameLimit = 0;
Body* bodies;
timeUnit* frameTimes;
// functions
timeUnit simStep();
timeUnit simStepOMP();
void init();
void teardown();

void DoSomethingWithBodies() {
  return;
  volatile unsigned u = 0;
  // to stop the compiler hoptimising everything out.
  while (u) {
    std::this_thread::sleep_for(std::chrono::seconds(1000));
  }
  //  std::this_thread::sleep_for(std::chrono::seconds(1));
  NO_OPT(bodies);
}

int main(int argc, char* argv[]) {
  size_t bodyCount_min, bodyCount_max;
  // defaults
  bodyCount_max = bodyCount_min = DEAFULT_BODYCOUNT;
  frameLimit = DEAFULT_FRAMELIMIT;
  size_t runs = DEAFULT_RUNS;
  size_t step = DEAFULT_BODYCOUNT_STEP;
  verbosity = DEAFULT_VERBOSITY;
  selectedAlgo = DEAFULT_ALGO;
  //
  if (argc > 1) {
    frameLimit = (size_t)std::stoul(argv[1]);
  }
  if (argc > 2) {
    bodyCount_max = (size_t)std::stoul(argv[2]);
    bodyCount_min = bodyCount_max;
  }
  if (argc > 3) {
    bodyCount_min = (size_t)std::stoul(argv[3]);
  }
  if (argc > 4) {
    runs = (size_t)std::stoul(argv[4]);
  }
  if (argc > 5) {
    step = (size_t)std::stoul(argv[5]);
  }
  if (argc > 6) {
    verbosity = (uint8_t)std::stoul(argv[6]);
  }
  if (argc > 7) {
    selectedAlgo = (algo)std::stoul(argv[7]);
  }

  log(1, std::cout << "AGO:" << selectedAlgo << std::endl);
  loge(1, std::cout << "BC,\tTicks,\tRuns,\tMean,\tSD,\tSpeedPerBody" << std::endl);
  for (size_t k = bodyCount_min; k <= bodyCount_max; k += step) {
    bodyCount = k;
    init();
    Metric* metrics = new Metric[runs];
    log(2, std::cout << "---\nBodycount:" << k << ",\tFrames " << frameLimit << ",\tStarting "
                     << runs << " runs" << std::endl);
    for (size_t r = 0; r < runs; r++) {
      for (size_t i = 0; i < frameLimit; i++) {
        switch (selectedAlgo) {
        case CPUSEQ:
          frameTimes[i] = simStep();
          break;
        case CPUOMP:
          frameTimes[i] = simStepOMP();
          break;
        default:
          break;
        }
        DoSomethingWithBodies();
      }
      metrics[r] = getMetrics(frameTimes, frameLimit);
      loge(3, std::cout << metrics[r] << std::endl);
      loge(2, std::cout << '.');
    }
    loge(2, std::cout << std::endl;);
    log(2, std::cout << "--- " << bodyCount << "," << frameLimit << "," << runs << std::endl);
    log(2, std::cout << "Total SD:\t" << getMetrics(metrics, runs, GETSD) << std::endl);
    log(2, std::cout << "Total Mean:\t" << getMetrics(metrics, runs, GETMEAN) << std::endl);

    loge(1, const auto m = getMetrics(metrics, runs, GETMEAN).mean;
         std::cout << bodyCount << ",\t" << frameLimit << ",\t" << runs << ",\t" << m << ",\t"
                   << getMetrics(metrics, runs, GETSD).mean << ",\t" << (m / (accuracy)bodyCount)
                   << std::endl);
    teardown();
  }
}

void init() {
  std::default_random_engine generator;
  generator.seed(123456);
  std::uniform_real_distribution<accuracy> distrX(0, (accuracy)1000);
  std::uniform_real_distribution<accuracy> distrY(0, (accuracy)1000);
  std::uniform_real_distribution<accuracy> distrZ(0, (accuracy)1000);
  bodies = new Body[bodyCount];
  for (size_t i = 0; i < bodyCount; i++) {
    bodies[i].pos = Vec3(distrX(generator), distrY(generator), distrZ(generator));
  }
  frameTimes = new timeUnit[frameLimit];
}

void teardown() {
  delete[] bodies;
  bodies = nullptr;
  delete[] frameTimes;
  frameTimes = nullptr;
}

timeUnit simStep() {
  // volatile unsigned u = 0;
  const auto start = std::chrono::high_resolution_clock::now();
  const accuracy delta = 1;
  for (int i = 0; i < bodyCount; i++) {
    Vec3 newVelo;
    const auto pos = bodies[i].pos;
    for (int j = 0; j < bodyCount; j++) {
      if (j == i) {
        continue;
      }
      const Vec3 r = bodies[j].pos - pos;
      const accuracy distSqr = Vec3::dot(r, r);
      if (distSqr > 0.1f) {
        accuracy invDist = 1.0f / sqrtf(distSqr);
        accuracy invDist3 = invDist * invDist * invDist;
        newVelo += r * invDist3;
      }
    }
    // slow down when far from origin.
    bodies[i].speed += (newVelo * delta) - (bodies[i].pos * (accuracy)0.000001f);
    bodies[i].pos += bodies[i].speed;
  }
  const auto end = std::chrono::high_resolution_clock::now();
  return std::chrono::duration_cast<timeUnit>(end - start);
}

timeUnit simStepOMP() {
  const auto start = std::chrono::high_resolution_clock::now();
  const accuracy delta = 1;
#pragma omp parallel for shared(bodies, bodyCount)
  for (int i = 0; i < bodyCount; i++) {
    Vec3 newVelo;
    const auto pos = bodies[i].pos;
    for (int j = 0; j < bodyCount; j++) {
      if (j == i) {
        continue;
      }
      const Vec3 r = bodies[j].pos - pos;
      const accuracy distSqr = Vec3::dot(r, r);
      if (distSqr > 0.1f) {
        accuracy invDist = 1.0f / sqrtf(distSqr);
        accuracy invDistCubed = invDist * invDist * invDist;
        newVelo += (r * invDistCubed);
      }
    }
    // slow down when far from origin.
    bodies[i].speed += (newVelo * delta) - (bodies[i].pos * (accuracy)0.000001f);
    bodies[i].pos += bodies[i].speed;
  }
  const auto end = std::chrono::high_resolution_clock::now();
  return std::chrono::duration_cast<timeUnit>(end - start);
}
