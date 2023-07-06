import 'package:english_dictionary/presenter/dictionary/cubit/dictionary_cubit.dart';
import 'package:english_dictionary/presenter/dictionary/page/widgets/latest_viewed_words_widget.dart';
import 'package:english_dictionary/presenter/dictionary/page/widgets/word_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  final dictorionaryCubit = GetIt.I.get<DictionaryCubit>();

  @override
  void initState() {
    Future.wait([dictorionaryCubit.onInit()]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<DictionaryCubit, DictionaryState>(
        bloc: dictorionaryCubit,
        builder: (context, state) {
          return SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: LastestViewedWordsWidget(),
                ),
                const SizedBox(height: 10),
                Builder(builder: (context) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: WordListWidget(
                        words: state.words,
                        isLoading: state.loading,
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}
