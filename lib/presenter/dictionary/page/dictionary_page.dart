import 'package:english_dictionary/core/feature/history/cubit/history_cubit.dart';
import 'package:english_dictionary/core/feature/words/cubit/words_cubit.dart';
import 'package:english_dictionary/presenter/dictionary/widgets/custom_list_controller.dart';
import 'package:english_dictionary/presenter/dictionary/widgets/word_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  final wordsCubit = GetIt.I.get<WordsCubit>();

  @override
  void initState() {
    Future.wait([wordsCubit.getWords()]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocBuilder<WordsCubit, WordsState>(
          bloc: wordsCubit,
          builder: (context, state) {
            return SizedBox(
              width: size.width,
              height: size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  BlocBuilder<HistoryCubit, HistoryState>(
                    bloc: GetIt.I.get<HistoryCubit>(),
                    builder: (context, state) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: CustomListController(),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: WordListWidget(
                        words: state.words,
                        isLoading: state.loading,
                        iaLoading: state.aiLoading,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
