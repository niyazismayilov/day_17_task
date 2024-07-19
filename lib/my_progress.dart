import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:progress_border/progress_border.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProbressBorder Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'ProbressBorder Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late final animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
  );
  double borderWidth = 8;

  @override
  void initState() {
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void restart() {
    if (animationController.status == AnimationStatus.forward ||
        animationController.value >= 1) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  Widget createSquare(
      double strokeAlign,
      String text, {
        Color? backgroundColor,
        Gradient? backgroundGradient,
        Gradient? gradient,
        BoxShape shape = BoxShape.circle,
        BorderRadiusGeometry? borderRadius,
        bool clockwise = true,
      }) {
    return Container(
      width: 100,
      height: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blue.withAlpha(100),
        shape: shape,
        borderRadius: borderRadius,
        border: ProgressBorder.all(
          color: Colors.blue,
          width: borderWidth,
          progress: animationController.value,
          backgroundColor: backgroundColor,
        ),
      ),
      child: Text(text),
    );
  }

  Widget createRow({
    Color? backgroundColor,
    Gradient? backgroundGradient,
    Gradient? gradient,
    BoxShape shape = BoxShape.circle,
    BorderRadiusGeometry? borderRadius,
    bool clockwise = true,
  }) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: createSquare(
              30.0,
              'Inside',
              backgroundColor: backgroundColor,
              backgroundGradient: backgroundGradient,
              gradient: gradient,
              shape: shape,
              borderRadius: borderRadius,
              clockwise: clockwise,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 16, bottom: 8),
              child: Text('BoxShape.circle'),
            ),
            createRow(),
           ]
        ),
      ),
    );
  }
}