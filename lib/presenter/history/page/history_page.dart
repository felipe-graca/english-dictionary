import 'package:english_dictionary/core/feature/history/cubit/history_cubit.dart';
import 'package:english_dictionary/core/feature/history/domain/entities/history_word_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/presenter/word/page/word_page.dart';
import 'package:english_dictionary/ui/global/custom_card/custom_card.dart';
import 'package:english_dictionary/ui/global/history_tile/history_tile_widget.dart';
import 'package:english_dictionary/ui/global/modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final historyCubit = GetIt.I.get<HistoryCubit>();

  @override
  void initState() {
    Future.wait([historyCubit.getHistoryWords()]);
    super.initState();
  }

  @override
  void dispose() {
    historyCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<HistoryCubit, HistoryState>(
      bloc: historyCubit,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'History Words',
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
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: CustomCard(
                  child: SizedBox(
                    width: size.width,
                    height: size.height,
                    child: Center(
                      child: state.loading
                          ? const CircularProgressIndicator()
                          : state.words.isEmpty && state.errorMessage != ''
                              ? Center(
                                  child: Text(
                                    'Sorry nothing to see here 🙁',
                                    style: GoogleFonts.lato(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.98,
                                      color: const Color.fromRGBO(102, 106, 214, 0.59),
                                    ),
                                  ),
                                )
                              : _buildBody(isLoading: state.loading, words: state.words),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildBody({required bool isLoading, required List<HistoryWordEntity> words}) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return BlocBuilder<HistoryCubit, HistoryState>(
      bloc: historyCubit,
      builder: (context, state) {
        return ListView.separated(
          itemCount: words.length,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          itemBuilder: (context, index) {
            final word = words[index];
            return HistoryTileWidget(
              word: word,
              onTap: () async {
                historyCubit.saveHistoryWord(word);
                await openModalBottomSheet(context: context, child: WordPage(word: toWordEntity(word)));
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 15),
        );
      },
    );
  }

  WordEntity toWordEntity(HistoryWordEntity word) {
    return WordEntity(
      word: word.word,
      id: word.id,
    );
  }
}
