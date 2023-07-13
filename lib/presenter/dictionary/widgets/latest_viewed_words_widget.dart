import 'package:english_dictionary/ui/global/custom_card/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LastestViewedWordsWidget extends StatefulWidget {
  const LastestViewedWordsWidget({super.key});

  @override
  State<LastestViewedWordsWidget> createState() => _LastestViewedWordsWidgetState();
}

class _LastestViewedWordsWidgetState extends State<LastestViewedWordsWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Lastest viewed words',
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
              height: 174,
              width: size.width,
              child: GridView.builder(
                padding: const EdgeInsets.only(top: 5),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 8,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4.5,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 10),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: const Color(0xFF797CDB),
                              width: 2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: SizedBox(
                            width: 100,
                            height: 20,
                            child: Text(
                              'Management',
                              style: GoogleFonts.lato(
                                  fontSize: 15, fontWeight: FontWeight.w500, color: const Color.fromRGBO(63, 63, 63, 0.59), height: 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
