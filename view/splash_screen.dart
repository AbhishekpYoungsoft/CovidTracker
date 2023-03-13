import 'dart:async';

import 'package:covidtrackerapp/view/worldstats.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  //---
  //AnimationController? _controller;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override
  void initState() {
    super.initState();

    //so that after that much seconds the page is moved to next page
    Timer(
        const Duration(seconds: 5),
        () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const WorldStats(), // so after 5 seconds page is pushed to worldsstates page
            )));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              child: const SizedBox(
                height: 100,
                width: 100,
                child: Center(
                  child: Image(
                    image: AssetImage('images/virus.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              builder: (context, Widget? child) {
                return Transform.rotate(
                  angle: _controller.value * 2.0 * math.pi,
                  child: child,
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            const Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "COVID-19\nTracker App",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                )),
          ],
        ),
      ),
    );
  }
}
