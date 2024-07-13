import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_oscilloscope/math.dart';
import 'package:flutter_oscilloscope/chart.dart';
import 'package:function_tree/function_tree.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const OscilloscopeApp());
}

class OscilloscopeApp extends StatelessWidget {
  const OscilloscopeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  var _function = SingleVariableFunction(
    fromExpression: '2*sin(4*pi*t)-cos(20*pi*t)',
    withVariable: 't',
  );
  var _numberOfSamples = 128;
  var _durationInSeconds = 3.2;
  var _samplingPeriod = 1.0; //to be updated inside loop
  List<double> _samples = [1];
  List<double> _fftAmplitudes = [1];
  Ticker? _ticker;

  @override
  void initState() {
    _ticker = createTicker(_functionGenerator);
    _ticker!.start();
    super.initState();
  }

  @override
  void dispose() {
    _ticker?.dispose();
    super.dispose();
  }

  void _functionGenerator(Duration duration) {
    final t = duration.inMicroseconds / 1E6;
    _samplingPeriod = _durationInSeconds / _numberOfSamples;
    _samples = List.generate(_numberOfSamples, (i) => _function(t + i * _samplingPeriod).toDouble());
    _fftAmplitudes = fft(_samples.map((e) => Complex(e, 0)).toList()).map((e) => e.abs()).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Oscilloscope')),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 32),
          Text(
            'Function:',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 4),
          Math.tex(
            '\nf(t)=${_function.tex.replaceAll('cdot', '\\cdot')}',
            textStyle: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 32),
          Text(
            'Time Window: ${NumberFormat.compact().format(_durationInSeconds)}s',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Slider(
            value: log(_durationInSeconds) / log(10),
            min: -6,
            max: 6,
            label: _durationInSeconds.toString(),
            onChanged: (value) {
              _durationInSeconds = pow(10, value).toDouble();
              setState(() {});
            },
          ),
          const SizedBox(height: 32),
          Text(
            'Time Domain:',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Chart(data: _samples),
          const SizedBox(height: 32),
          Text(
            'FFT:',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Chart(data: _fftAmplitudes.sublist(0, _fftAmplitudes.length ~/ 2)),
          Row(
            children: [
              const Text('0Hz'),
              const Spacer(),
              Text('${NumberFormat.compact().format(1 / _samplingPeriod / 2)}Hz'),
            ],
          )
        ],
      ),
    );
  }
}
