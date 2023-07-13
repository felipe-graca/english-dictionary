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
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      if (leftIcon != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(
                            leftIcon,
                            color: const Color(0xFFAEAEC0),
                          ),
                        ),
                      if (isLoading)
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFFAEAEC0),
                            ),
                          ),
                        )
                      else
                        Text(
                          label,
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.98,
                            color: const Color(0xFFAEAEC0),
                          ),
                        ),
                      if (rightIcon != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Icon(
                            rightIcon,
                            color: const Color(0xFFAEAEC0),
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class DangerButton extends StatelessWidget {
  final String label;
  final void Function()? onTap;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final double? width;
  final bool isLoading;

  final bool fullWidth;

  const DangerButton({
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
              width: fullWidth ? width : 250,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                  color: const Color.fromARGB(255, 71, 71, 71)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      if (leftIcon != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(
                            leftIcon,
                            color: const Color(0xFFAEAEC0),
                          ),
                        ),
                      if (isLoading)
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFFAEAEC0),
                            ),
                          ),
                        )
                      else
                        Text(
                          label,
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.98,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      if (rightIcon != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Icon(
                            rightIcon,
                            color: const Color(0xFFAEAEC0),
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
