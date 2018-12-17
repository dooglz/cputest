#include "CLI11.hpp"
#include <chrono>
#include <cmath>
#include <iostream>
#include <random>
#include <string>
#include <thread>
#include <omp.h>

//#define accuracy float
#define accuracy double
//#define accuracy long double
#define timeUnit std::chrono::microseconds
#define DEFAULT_BODYCOUNT 50
#define DEFAULT_BODYCOUNT_STEP 50
#define DEFAULT_FRAMELIMIT 100
#define DEFAULT_RUNS 5
#define DEFAULT_VERBOSITY 1
#define DEFAULT_ALGO CPUSEQ
#define DEFAULT_SLEEP 0
enum algo { CPUSEQ, CPUOMP };
// must include v this v after ^these macros^
#include "mathsandthings.h"

// globals
algo selectedAlgo = CPUSEQ;
uint8_t verbosity = 0;
size_t bodyCount = 0;
size_t frameLimit = 0;
size_t sleeptimeT = 0;
Body *bodies;
timeUnit *frameTimes;

// functions
timeUnit simStep();
timeUnit simStepOMP();
void init();
void teardown();

void DoSomethingWithBodies() {
  return;
  volatile unsigned u = 0;
  // to stop the compiler optimising everything out.
  while (u) {
    std::this_thread::sleep_for(std::chrono::seconds(1000));
  }
  NO_OPT(bodies);
}

int main(int argc, char **argv) {
  size_t bodyCount_min, bodyCount_max, sleeptimeR, runs, step;
  // defaults
  bodyCount_max = bodyCount_min = DEFAULT_BODYCOUNT;
  frameLimit = DEFAULT_FRAMELIMIT;
  runs = DEFAULT_RUNS;
  step = DEFAULT_BODYCOUNT_STEP;
  verbosity = DEFAULT_VERBOSITY;
  selectedAlgo = DEFAULT_ALGO;
  sleeptimeR = sleeptimeT = DEFAULT_SLEEP;
  // parse cmdline
  CLI::App app{"CPU NBODY TEST"};
  app.add_option("--bmax", bodyCount_max, "BodyCount Max");
  app.add_option("--bmin", bodyCount_min, "BodyCount Max");
  app.add_option("--bs", step, "BodyCount step");
  app.add_option("-f", frameLimit, "Physics frames per run");
  app.add_option("-r", runs, "Runs per BodyCount");
  app.add_option("-v", verbosity, "verbosity (0,1,2,3)");
  app.add_option("-a", selectedAlgo, "ALGO(0,1,2)");
  app.add_option("--sleepR", sleeptimeR, "sleep time between Runs");
  app.add_option("--sleepT", sleeptimeT, "sleep time between Ticks");
  CLI11_PARSE(app, argc, argv);
  // sanitize limits
  bodyCount_min = std::min(bodyCount_min, bodyCount_max);
  bodyCount_max = std::max(bodyCount_max, bodyCount_min);
  // Print Headder
  log(1, "BC: " << bodyCount_min << " ->" << bodyCount_max << " " << step);
  log(1, "AGO:" << selectedAlgo << "\nSleepT:" << sleeptimeT << ",SleepR:" << sleeptimeR << "\nTicks:" << frameLimit
                << "\ntRuns:" << runs << "\nOMP threads:" << omp_get_max_threads());
  loge(1, "BC,Ticks,Runs,Mean,SD,Time/Body,RunTime");
  // GO!
  for (size_t k = bodyCount_min; k <= bodyCount_max; k += step) {
    bodyCount = k;
    Metric *metrics = new Metric[runs];
    auto walltimes = new timeUnit[runs];
    log(2, "---\nBodycount:" << k << ",\tFrames " << frameLimit << ",\tStarting " << runs << " runs");

    for (size_t r = 0; r < runs; r++) {
      init();
      const auto RunStart = std::chrono::high_resolution_clock::now();
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
        if (sleeptimeT > 0) {
          std::this_thread::sleep_for(std::chrono::milliseconds(sleeptimeT));
        }
        DoSomethingWithBodies();
      }//end Tick loop
      const auto runEnd = std::chrono::high_resolution_clock::now();
      teardown();
      walltimes[r] = std::chrono::duration_cast<timeUnit>(runEnd - RunStart);
      //--Print Metrics
      metrics[r] = getMetrics(frameTimes, frameLimit);
      log(2, metrics[r]);
      if (sleeptimeR > 0) {
        log(3, "Sleeping for " << sleeptimeR << "ms");
        std::this_thread::sleep_for(std::chrono::milliseconds(sleeptimeR));
      }
    }//end Run loop
    const auto m = getMetrics(metrics, runs, GETMEAN).mean;
    const auto wtm = getMetrics(walltimes, runs);
    log(1, bodyCount << "," << frameLimit << "," << runs << "," << m << "," << getMetrics(metrics, runs, GETSD).mean
                     << "," << (m / (accuracy)bodyCount) << "," << wtm.mean);
    delete[] metrics;
    delete[] walltimes;
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
        accuracy invDist = ((accuracy)1.0) / sqrt(distSqr);
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
        accuracy invDist = ((accuracy)1.0) / sqrt(distSqr);
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
