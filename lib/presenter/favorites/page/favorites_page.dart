import 'package:english_dictionary/core/feature/favorites/cubit/favorites_cubit.dart';
import 'package:english_dictionary/core/feature/favorites/domain/entities/favorite_word_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/presenter/word/page/word_page.dart';
import 'package:english_dictionary/ui/global/custom_card/custom_card.dart';
import 'package:english_dictionary/ui/global/modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:english_dictionary/ui/global/word_tile/word_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

class FivoritesPage extends StatefulWidget {
  const FivoritesPage({super.key});

  @override
  State<FivoritesPage> createState() => _FivoritesPageState();
}

class _FivoritesPageState extends State<FivoritesPage> {
  final favoritesCubit = GetIt.I.get<FavoritesCubit>();

  @override
  void initState() {
    Future.wait([favoritesCubit.getFavoritesWords()]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      bloc: favoritesCubit,
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
                'Favorite Words',
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
                      child: _buildBody(isLoading: (state.loading && state.words.isEmpty), words: state.words),
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

  Widget _buildBody({required bool isLoading, required List<FavoriteWordEntity> words}) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (words.isEmpty) {
      return Center(
        child: Text(
          'Sorry nothing to see here 🙁',
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.98,
            color: const Color.fromRGBO(102, 106, 214, 0.59),
          ),
        ),
      );
    }
    return ListView.separated(
      itemCount: words.length,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      itemBuilder: (context, index) {
        final word = words[index];
        return WordTileWidget(
          word: word.word,
          onTap: () async {
            await openModalBottomSheet(context: context, child: WordPage(word: convertFavoriteWordEntityToWordEntity(word)));
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 15),
    );
  }

  WordEntity convertFavoriteWordEntityToWordEntity(FavoriteWordEntity favoriteWordEntity) {
    return WordEntity(id: favoriteWordEntity.id, word: favoriteWordEntity.word);
  }
}
