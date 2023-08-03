import 'package:english_dictionary/core/feature/history/cubit/history_cubit.dart';
import 'package:english_dictionary/core/feature/history/domain/entities/history_word_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/presenter/word/page/word_page.dart';
import 'package:english_dictionary/ui/global/light_components/buttons/buttons.dart';
import 'package:english_dictionary/ui/global/light_components/custom_card/custom_card.dart';
import 'package:english_dictionary/ui/shared/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomWordList extends StatelessWidget {
  final bool isLoading;
  final List<WordEntity> words;
  final bool iaLoading;
  const CustomWordList({super.key, required this.words, required this.isLoading, this.iaLoading = false});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final historyCubit = GetIt.I.get<HistoryCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: iaLoading ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
            children: [
              Text(
                'Word List',
                style: GoogleFonts.lato(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.98,
                  color: const Color.fromRGBO(102, 106, 214, 0.59),
                ),
              ),
              if (iaLoading) ...[
                const SizedBox(width: 10),
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(color: Colors.black, strokeWidth: 0.5),
                ),
              ]
            ],
          ),
        ),
        const SizedBox(height: 8),
        Flexible(
          child: CustomCard(
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : BlocBuilder<HistoryCubit, HistoryState>(
                        bloc: historyCubit,
                        builder: (context, state) {
                          return ListView.separated(
                            itemCount: words.length,
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                            itemBuilder: (context, index) {
                              final word = words[index];
                              return BadgeButton(
                                label: word.word,
                                rightIcon: Icons.arrow_forward_ios_rounded,
                                onTap: () async {
                                  await openModalBottomSheet(context: context, child: WordPage(word: word));
                                },
                                isActived: state.words.any((element) => element.id == word.id),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 15),
                          );
                        },
                      ),
              ),
            ),
          ),
        )
      ],
    );
  }

  HistoryWordEntity toHistoryWordEntity(WordEntity word) {
    return HistoryWordEntity(
      id: word.id,
      word: word.word,
    );
  }
}
