import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final Widget child;
  const CardWidget({super.key, required this.child});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(205, 205, 205, 0.25),
            blurRadius: 8,
            offset: Offset(2, -2),
          ),
          BoxShadow(
            color: Color.fromRGBO(205, 205, 205, 0.45),
            blurRadius: 8,
            offset: Offset(-2, 2),
          ),
        ],
      ),
      child: widget.child,
    );
  }
}
