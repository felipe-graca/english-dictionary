import 'package:english_dictionary/core/feature/history/cubit/history_cubit.dart';
import 'package:english_dictionary/core/feature/words/cubit/words_cubit.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/core/utils/utils.dart';
import 'package:english_dictionary/presenter/word/page/word_page.dart';
import 'package:english_dictionary/ui/global/light_components/buttons/buttons.dart';
import 'package:english_dictionary/ui/global/light_components/custom_card/custom_card.dart';
import 'package:english_dictionary/ui/global/light_components/custom_text_field/custom_text_field.dart';
import 'package:english_dictionary/ui/shared/custom_snackbar.dart';
import 'package:english_dictionary/ui/shared/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListController extends StatefulWidget {
  const CustomListController({super.key});

  @override
  State<CustomListController> createState() => _CustomListControllerState();
}

class _CustomListControllerState extends State<CustomListController> {
  final specificWordController = TextEditingController();
  final relatedWordController = TextEditingController();

  final specificWordFocusNode = FocusNode();
  final relatedWordFocusNode = FocusNode();

  final wordsCubit = GetIt.I.get<WordsCubit>();
  final historyCubit = GetIt.I.get<HistoryCubit>();

  @override
  void initState() {
    super.initState();
  }

  void unFocus() {
    specificWordFocusNode.unfocus();
    relatedWordFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<WordsCubit, WordsState>(
      bloc: wordsCubit,
      builder: (context, state) {
        return SizedBox(
          width: size.width,
          child: GestureDetector(
            onTap: unFocus,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'List controller',
                    style: GoogleFonts.lato(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.98,
                      color: const Color.fromRGBO(102, 106, 214, 0.59),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                CustomCard(
                  child: SizedBox(
                    height: 200,
                    width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 2, bottom: 5),
                                child: Text(
                                  'Specific word',
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 1.5,
                                    color: const Color(0xFF515151),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      hint: 'Enter a specific word',
                                      controller: specificWordController,
                                      focusNode: specificWordFocusNode,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  CustomIconButton(
                                    icon: Icons.search,
                                    onTap: () async {
                                      await openModalBottomSheet(
                                        context: context,
                                        child: WordPage(word: WordEntity(word: specificWordController.text, id: Utils.generateUid)),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 2, bottom: 5),
                                child: Text(
                                  'Related word',
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 1.5,
                                    color: const Color(0xFF515151),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      hint: 'Enter word to generate list',
                                      controller: relatedWordController,
                                      focusNode: relatedWordFocusNode,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  CustomIconButton(
                                    icon: Icons.generating_tokens_outlined,
                                    onTap: () async {
                                      FocusScope.of(context).unfocus();
                                      if (relatedWordController.text.length < 3) {
                                        CustomSnackBar.show(
                                          text: 'Please type an valid word or phrase',
                                          status: CustomSnackbarStatus.warning,
                                          context: context,
                                        );
                                        return;
                                      }
                                      CustomSnackBar.show(
                                        text: 'Searching for words... 🔎',
                                        status: CustomSnackbarStatus.success,
                                        context: context,
                                      );
                                      await wordsCubit.getAiWords(
                                        relatedWordController.text,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
