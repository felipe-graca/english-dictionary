import 'package:flutter/material.dart';

class CustomLoadingAnimation extends StatefulWidget {
  const CustomLoadingAnimation({super.key});

  @override
  State<CustomLoadingAnimation> createState() => _CustomLoadingAnimationState();
}

class _CustomLoadingAnimationState extends State<CustomLoadingAnimation> {
  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(102, 106, 214, 0.59)),
      strokeWidth: 1,
    );
  }
}
