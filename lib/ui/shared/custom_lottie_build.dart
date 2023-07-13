import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLottieBuilder extends StatefulWidget {
  const CustomLottieBuilder({super.key});

  @override
  State<CustomLottieBuilder> createState() => _CustomLottieBuilderState();
}

class _CustomLottieBuilderState extends State<CustomLottieBuilder> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/jsons/loading_animation.json', // Replace with your animation path
      controller: _controller,
      onLoaded: (composition) {
        _controller.duration = composition.duration;
        _controller.repeat();
      },
    );
  }
}
