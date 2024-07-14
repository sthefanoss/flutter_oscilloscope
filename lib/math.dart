import 'dart:math';

import 'package:function_tree/function_tree.dart';

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

/// Returns a random number between -1 and 1
double noise() => 2 * _random.nextDouble() - 1;

List<double> generateSamples(
  SingleVariableFunction function, {
  required int length,
  required double xStep,
  required double noiseLevel,
  required double initialX,
}) =>
    List<double>.generate(length, (i) {
      final x = initialX - (length - i - 1) * xStep;
      return function(x) + noise() * noiseLevel;
    });

extension NumericListExtensions on List<num> {
  List<Complex> asComplexList() => map((e) => Complex(e.toDouble(), 0)).toList();
}
