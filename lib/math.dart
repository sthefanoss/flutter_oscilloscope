import 'dart:math';

final _random = Random();

class Complex {
  final double real;
  final double imag;

  const Complex(this.real, this.imag);

  Complex operator +(Complex other) => Complex(real + other.real, imag + other.imag);
  Complex operator -(Complex other) => Complex(real - other.real, imag - other.imag);
  Complex operator *(Complex other) =>
      Complex(real * other.real - imag * other.imag, real * other.imag + imag * other.real);

  double abs() => sqrt(real * real + imag * imag);

  double arg() => atan2(imag, real);

  @override
  String toString() => '($real + ${imag}i)';
}

List<Complex> fft(List<Complex> x) {
  int N = x.length;
  if (N <= 1) return x;

  List<Complex> even = List.generate(N ~/ 2, (i) => x[i * 2]);
  List<Complex> odd = List.generate(N ~/ 2, (i) => x[i * 2 + 1]);

  List<Complex> fftEven = fft(even);
  List<Complex> fftOdd = fft(odd);

  List<Complex> result = List.generate(N, (i) => const Complex(0, 0));

  for (int k = 0; k < N ~/ 2; k++) {
    double angle = -2 * pi * k / N;
    Complex twiddle = Complex(cos(angle), sin(angle)) * fftOdd[k];
    result[k] = fftEven[k] + twiddle;
    result[k + N ~/ 2] = fftEven[k] - twiddle;
  }

  return result;
}

double noise() => _random.nextDouble() - 0.5;
