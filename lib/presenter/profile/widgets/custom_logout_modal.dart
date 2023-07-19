import 'package:english_dictionary/ui/global/light_components/buttons/buttons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class CustomLogoutModal extends StatelessWidget {
  final Function() logout;
  const CustomLogoutModal({super.key, required this.logout});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/jsons/logout_animation.json',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 10),
            Text('Are you sure you want to logout?', style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w300)),
            const SizedBox(height: 20),
            DangerButton(
              label: 'Yes, i want exit this app',
              onTap: logout,
            ),
          ],
        ),
      ),
    );
  }
}
