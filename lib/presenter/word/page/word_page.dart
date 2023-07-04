import 'package:english_dictionary/core/feature/favorites/cubit/favorites_cubit.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/presenter/word/cubit/word_cubit.dart';
import 'package:english_dictionary/presenter/word/page/widget/favorite_button_widget.dart';
import 'package:english_dictionary/presenter/word/page/widget/player_word_widget.dart';
import 'package:english_dictionary/ui/global/buttons/buttons.dart';
import 'package:english_dictionary/ui/global/custom_snackbar/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class WordPage extends StatefulWidget {
  final WordEntity word;
  const WordPage({super.key, required this.word});

  @override
  State<WordPage> createState() => _WordPageState();
}

class _WordPageState extends State<WordPage> {
  final wordCubit = GetIt.I.get<WordCubit>();
  final favoritesCubit = GetIt.I.get<FavoritesCubit>();

  @override
  void initState() {
    Future.wait([
      wordCubit.getWordSignification(widget.word),
    ]);
    super.initState();
  }

  String decodeSpecialCharacters(String text) {
    return Intl.withLocale('en_US.UTF-8', () => Intl.message(text, name: 'decodeSpecialCharacters'));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocBuilder<WordCubit, WordState>(
        bloc: wordCubit,
        builder: (context, state) {
          return SizedBox(
            width: size.width,
            height: size.height - 50,
            child: state.isLoading
                ? const Center(
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                    ),
                  )
                : (wordCubit.hasFailure
                    ? Center(
                        child: Text(
                          'Sorry nothing to see here 🙁',
                          style: GoogleFonts.lato(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.98,
                            color: const Color(0xFF515151),
                          ),
                        ),
                      )
                    : _buildBody(state)),
          );
        },
      ),
    );
  }

  Widget _buildBody(WordState state) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.wordSignificationEntity.word.substring(0, 1).toUpperCase() +
                              state.wordSignificationEntity.word.substring(1, state.wordSignificationEntity.word.length),
                          style: GoogleFonts.lato(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.98,
                            color: const Color(0xFF515151),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<FavoritesCubit, FavoritesState>(
                    bloc: favoritesCubit,
                    builder: (context, state) {
                      return FavoriteButtonWidget(
                        onTap: () async {
                          if (wordCubit.isFavorite) {
                            final result = await favoritesCubit.removeFavoriteWord(widget.word);
                            if (result) {
                              if (!mounted) return;
                              CustomSnackBar.show(
                                text: '${wordCubit.state.word.word}, was removed from favorites!',
                                status: CustomSnackbarStatus.success,
                                context: context,
                              );
                              return;
                            }
                            if (!mounted) return;
                            CustomSnackBar.show(text: state.errorMessage, status: CustomSnackbarStatus.error, context: context);
                            return;
                          }
                          final result = await favoritesCubit.saveFavoriteWord(widget.word);
                          if (result) {
                            if (!mounted) return;
                            CustomSnackBar.show(
                              text: '${wordCubit.state.word.word}, was added to favorites ',
                              status: CustomSnackbarStatus.success,
                              context: context,
                            );
                            return;
                          }
                          if (!mounted) return;
                          CustomSnackBar.show(
                            text: state.errorMessage,
                            status: CustomSnackbarStatus.error,
                            context: context,
                          );
                        },
                        isFavorite: wordCubit.isFavorite,
                        isLoading: state.wasSubmitted,
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: buildOptions(
                path: 'assets/icons/pronunciation.svg',
                title: 'Pronunciation',
                value: decodeSpecialCharacters(state.wordSignificationEntity.pronunciation.all),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: buildOptions(
                path: 'assets/icons/word.svg',
                title: 'Word',
                value: state.wordSignificationEntity.word,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: buildOptions(
                path: 'assets/icons/definition.svg',
                title: 'Definition',
                value: state.wordSignificationEntity.results.first.definition,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: buildOptions(
                path: 'assets/icons/example.svg',
                title: 'Example',
                value: state.example.examples.isEmpty ? 'No example' : state.example.examples.first,
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(left: 60, right: 60, bottom: 60),
            child: PrimaryButton(
              label: 'Next word',
              isLoading: state.wasSubmitted,
              onTap: () {
                wordCubit.nextWord();
              },
              fullWidth: true,
            ),
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: PlayerWordWidget(),
          ),
        ),
      ],
    );
  }

  Widget buildOptions({
    required String path,
    required String title,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            title,
            style: GoogleFonts.lato(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.98,
              color: const Color(0xFF515151),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                path,
                width: 60,
                height: 60,
              ),
              const SizedBox(width: 20),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, right: 15),
                  child: Text(
                    value.isEmpty ? 'No data' : value.substring(0, 1).toUpperCase() + value.substring(1, value.length),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.98,
                      color: Color(0xFF515151),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
