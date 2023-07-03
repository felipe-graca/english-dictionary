import 'package:flutter/material.dart';

class PlayButtonWidget extends StatelessWidget {
  final Function() onTap;
  final bool isPlayed;
  const PlayButtonWidget({super.key, required this.onTap, this.isPlayed = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: InkWell(
        onTap: onTap,
        child: Icon(
          isPlayed ? Icons.pause : Icons.play_arrow,
          color: isPlayed ? Colors.red : Colors.grey,
          size: 40,
        ),
      ),
    );
  }
}
