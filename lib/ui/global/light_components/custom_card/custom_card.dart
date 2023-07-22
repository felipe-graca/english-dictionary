import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final Widget child;
  const CustomCard({super.key, required this.child});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
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
