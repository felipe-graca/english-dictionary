import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WordTileWidget extends StatelessWidget {
  final String word;
  final bool isActived;
  const WordTileWidget({super.key, required this.word, this.isActived = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF797CDB),
        borderRadius: BorderRadius.circular(45),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: isActived ? const Color(0xFF00FF38) : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                word,
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  height: 1,
                ),
              ),
            ],
          ),
          const Icon(Icons.arrow_forward_ios, size: 15, color: Colors.white)
        ],
      ),
    );
  }
}
