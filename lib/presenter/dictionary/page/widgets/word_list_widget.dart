import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/presenter/word/page/word_page.dart';
import 'package:english_dictionary/ui/global/card/card_widget.dart';
import 'package:english_dictionary/ui/global/modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:english_dictionary/ui/global/word_tile/word_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WordListWidget extends StatelessWidget {
  final bool isLoading;
  final List<WordEntity> words;
  const WordListWidget({super.key, required this.words, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Word List',
            style: GoogleFonts.lato(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.98,
              color: const Color.fromRGBO(102, 106, 214, 0.59),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Flexible(
          child: CardWidget(
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : ListView.separated(
                        itemCount: words.length,
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        itemBuilder: (context, index) {
                          final word = words[index];
                          return WordTileWidget(
                            word: word,
                            onTap: () async {
                              await openModalBottomSheet(context: context, child: WordPage(word: word));
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 15),
                      ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
