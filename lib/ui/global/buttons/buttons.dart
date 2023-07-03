import 'package:english_dictionary/ui/shared/inner_shadow.dart';
import 'package:english_dictionary/ui/shared/touch_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final void Function()? onTap;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final double? width;
  final bool isLoading;

  final bool fullWidth;

  const PrimaryButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.leftIcon,
    this.rightIcon,
    this.width,
    this.isLoading = false,
    this.fullWidth = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchWrapper(
      onTap: () {
        if (onTap != null && !isLoading) {
          onTap!();
        }
      },
      builder: (value) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: TouchWrapper.interpolateOuterShadow([
              const BoxShadow(
                color: Colors.white,
                blurRadius: 9,
                offset: Offset(-4, -4),
              ),
              BoxShadow(
                color: const Color(0xFFAEAEC0).withOpacity(0.5),
                blurRadius: 9,
                offset: const Offset(4, 4),
              ),
            ], value),
            borderRadius: BorderRadius.circular(8),
          ),
          child: InnerShadow(
            shadows: TouchWrapper.interpolateInnerShadow([], value),
            child: Container(
              width: fullWidth ? width : 200,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                  color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (leftIcon != null && !isLoading)
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Icon(leftIcon, size: 20),
                    ),
                  if (isLoading)
                    const Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 1),
                      ),
                    ),
                  if (!isLoading)
                    Text(label,
                        style: GoogleFonts.lato(
                          fontSize: 10,
                          color: const Color(0xFF6C7185),
                          fontWeight: FontWeight.w600,
                          height: 0.765,
                          letterSpacing: 2.8,
                        )),
                  if (rightIcon != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Icon(rightIcon, size: 20),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
