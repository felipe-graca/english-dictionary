import 'package:english_dictionary/core/feature/history/domain/entities/history_word_entity.dart';
import 'package:english_dictionary/ui/global/light_components/buttons/buttons.dart';
import 'package:english_dictionary/ui/global/light_components/custom_card/custom_card.dart';
import 'package:english_dictionary/ui/global/light_components/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListController extends StatefulWidget {
  final List<HistoryWordEntity> words;
  const CustomListController({super.key, required this.words});

  @override
  State<CustomListController> createState() => _CustomListControllerState();
}

class _CustomListControllerState extends State<CustomListController> {
  final specificWordController = TextEditingController();
  final relatedWordController = TextEditingController();

  final specificWordFocusNode = FocusNode();
  final relatedWordFocusNode = FocusNode();

  void unFocus() {
    specificWordFocusNode.unfocus();
    relatedWordFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                                onTap: () {},
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
                                onTap: () {},
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
  }
}