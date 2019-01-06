template <typename T> struct _Metric {
  T min, max, mean, sd;
  _Metric(T Min, T Max, T Mean, T Sd) : min(Min), max(Max), mean(Mean), sd(Sd) {}
  _Metric() : min(0), max(0), mean(0), sd(0) {}
};
typedef _Metric<accuracy> Metric;
std::ostream &operator<<(std::ostream &Str, Metric const &m) {
  Str << "avg:" << m.mean << ",\tSD:" << m.sd << ",\tMin:" << m.min << "(" << (m.min / m.mean) << "),\tMax:" << m.max
      << "(" << (m.max / m.mean) << ")";
  return Str;
}
template <typename T> struct _Vec3 {
  T x, y, z;
  _Vec3() : x(0), y(0), z(0){};
  _Vec3(T _x, T _y, T _z) : x(_x), y(_y), z(_z){};
  /*_Vec3& _Vec3::operator=(const _Vec3& r) {
    x = r.x;
    y = r.y;
    z = r.z;
  }*/
  const static T dot(_Vec3<T> a, _Vec3<T> b) { return (a.x * b.x) + (a.y * b.y) + (a.z * b.z); }
};
template <typename T> _Vec3<T> operator-(const _Vec3<T> &l, const _Vec3<T> &r) {
  return _Vec3<T>(l.x - r.x, l.y - r.y, l.z - r.z);
}
template <typename T> _Vec3<T> operator*(const _Vec3<T> &l, const T &r) { return _Vec3<T>(l.x * r, l.y * r, l.z * r); }
template <typename T> _Vec3<T> operator/(const _Vec3<T>& l, const T& r) {
  return _Vec3<T>(l.x / r, l.y / r, l.z / r);
}
template <typename T> _Vec3<T> operator+=(_Vec3<T> &l, const _Vec3<T> &r) {
  l.x += r.x;
  l.y += r.y;
  l.z += r.z;
  return l;
}
template <typename T> _Vec3<T> operator-=(_Vec3<T>& l, const _Vec3<T>& r) {
  l.x -= r.x;
  l.y -= r.y;
  l.z -= r.z;
  return l;
}

template <typename T> struct _Body {
  T pos, speed;
  _Body(T _p) : pos(_p){};
  _Body() = default;
};

template <typename T> struct _PBody : public _Body<T> {
  T forces;
  accuracy mass;
  _PBody() = default;
};


typedef _Vec3<accuracy> Vec3;
typedef _Body<Vec3> Body;
typedef _PBody<Vec3> PBody;

template <typename T, typename L> Metric getMetrics(T *arr, size_t size, L lambda) {
  accuracy min = std::numeric_limits<accuracy>::max();
  accuracy max = std::numeric_limits<accuracy>::min();
  accuracy sum = 0;
  for (size_t i = 0; i < size; i++) {
    const accuracy c = (accuracy)lambda(arr[i]);
    sum += c;
    min = std::min(min, c);
    max = std::max(max, c);
  }
  const accuracy mean = sum / ((accuracy)size);
  accuracy sd = 0;
  for (size_t i = 0; i < size; i++) {
    const accuracy c = (accuracy)lambda(arr[i]);
    sd += pow(c - mean, 2);
  }
  sd = sqrt(sd / size);
  return Metric{min, max, mean, sd};
}

const auto GETCOUNT = [](auto x) { return x.count(); };
const auto GETSD = [](auto x) { return x.sd; };
const auto GETMEAN = [](auto x) { return x.mean; };
template <typename T> Metric getMetrics(T *arr, size_t size) { return getMetrics(arr, size, GETCOUNT); }
#define log(level, a)                                                                                                  \
  if (verbosity >= level) {                                                                                            \
    std::cout << a << std::endl;                                                                                       \
  }
#define loge(level, a)                                                                                                 \
  if (verbosity == level) {                                                                                            \
    std::cout << a << std::endl;                                                                                       \
  }
extern volatile void *_TheVoid = 0;
extern volatile int _TheVoidI = 0;
#define NO_OPT(Var)                                                                                                    \
  _TheVoid = Var;                                                                                                      \
  _TheVoidI = (int)Var[0].pos.x;
//#define NOP std::this_thread::sleep_for(std::chrono::seconds(1000));
//#define NO_OPT(Var) while (Var){NOP}

std::istream &operator>>(std::istream &stream, algo &a) {
  uint8_t i;
  if (stream >> i)
    a = static_cast<algo>(i % 48); // haha oh wow. 1990s called.
  return stream;
}
