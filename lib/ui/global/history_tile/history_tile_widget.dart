import 'package:english_dictionary/core/feature/history/domain/entities/history_word_entity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryTileWidget extends StatelessWidget {
  final HistoryWordEntity word;
  final Function()? onTap;
  final bool isActived;
  const HistoryTileWidget({super.key, required this.word, this.isActived = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
                const SizedBox(
                  width: 30,
                  height: 30,
                  child: Icon(Icons.history, size: 15, color: Colors.white),
                ),
                const SizedBox(width: 10),
                Text(
                  word.word,
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
      ),
    );
  }
}
