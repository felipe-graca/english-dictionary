import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SnackbarToDisplayModel {
  final String text;
  final CustomSnackbarStatus status;
  final String page;

  SnackbarToDisplayModel({
    required this.text,
    required this.status,
    required this.page,
  });
}

enum CustomSnackbarStatus { success, error, warning }

class CustomSnackBar {
  CustomSnackBar._();

  static void show({
    required String text,
    required CustomSnackbarStatus status,
    required BuildContext context,
    double marginBottom = 0.0,
    VoidCallback? onClosed,
  }) {
    Color? contentColor;
    IconData? icon;

    if (status == CustomSnackbarStatus.success) {
      contentColor = Colors.green.shade600;
      icon = Icons.check;
    } else if (status == CustomSnackbarStatus.warning) {
      icon = Icons.warning_amber;
      contentColor = Colors.yellow.shade600;
    } else if (status == CustomSnackbarStatus.error) {
      icon = Icons.close;
      contentColor = Colors.red.shade600;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          content: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 157, 157, 158).withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(2, 2),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: const Color.fromARGB(255, 157, 157, 158).withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(-2, -2),
                  spreadRadius: 0,
                ),
              ],
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                Container(
                    width: 36,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: contentColor!,
                        width: 2.0,
                      ),
                    ),
                    child: Icon(icon, color: contentColor, size: 16)),
                const SizedBox(width: 8),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 4,
                      right: 4,
                      top: 2,
                    ),
                    child: Text(
                      text,
                      softWrap: true,
                      style: GoogleFonts.lato(
                        color: const Color.fromARGB(255, 75, 75, 75),
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1.98,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          padding: EdgeInsets.zero,
          margin: const EdgeInsets.all(20),
        ))
        .closed
        .then((value) => onClosed?.call());
  }

  static void showInvalidForm(BuildContext context) {
    show(
      text: 'Fill all required fields',
      status: CustomSnackbarStatus.error,
      context: context,
    );
  }

  static void showGenericError(BuildContext context) {
    show(
      text: 'Something went wrong, check your internet connection and try again',
      status: CustomSnackbarStatus.error,
      context: context,
    );
  }
}
