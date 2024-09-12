
  import 'package:flutter/material.dart';
  import 'HiremiScreen.dart';

  class SplashScreen extends StatefulWidget {
    @override
    _SplashScreenState createState() => _SplashScreenState();
  }

  class _SplashScreenState extends State<SplashScreen>
      with SingleTickerProviderStateMixin {
    late AnimationController _controller;
    late Animation<double> _animation;

    @override
    void initState() {
      super.initState();

      // Wait for 2 seconds before starting the animation
      Future.delayed(Duration(milliseconds: 1750), () {
        _controller.forward();
      });

      _controller = AnimationController(
        duration: const Duration(milliseconds: 1500),
        vsync: this,
      );

      _animation = Tween<double>(begin: 1.0, end: 300.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(0.0, 0.75, curve: Curves.easeInOut),
        ),
      )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // Wait for a short delay before transitioning to the new screen
          _startTimer();
        }
      });
    }

    void _startTimer() {
      Future.delayed(Duration(milliseconds: 350), () {
        Navigator.of(context).pushReplacement(_createRoute());
      });
    }

    Route _createRoute() {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => HiremiScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = 0.0;
          const end = 3.0;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return FadeTransition(
            opacity: animation.drive(tween),
            child: child,
          );
        },
      );
    }

    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      double imageSize = _animation.value * MediaQuery.of(context).size.width * 0.6;
      return Scaffold(
        backgroundColor: Color(0xFFC1272D), // Set the background color
        body: Center(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.scale(
                scale: _animation.value,
                child: child,
              );
            },
            child: Image.asset(
              'images/tie.png',
              width: imageSize,
              height: imageSize,
            ),
          ),
        ),
      );
    }
  }
