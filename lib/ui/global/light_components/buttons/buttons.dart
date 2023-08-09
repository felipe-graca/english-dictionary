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

//iconButton
class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final void Function()? onTap;
  final double? width;
  final bool isLoading;

  final bool fullWidth;

  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
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
              width: fullWidth ? width : 60,
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
                      if (isLoading)
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        )
                      else
                        Icon(
                          icon,
                          color: const Color(0xFFAEAEC0),
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

class BadgeButton extends StatelessWidget {
  final String label;
  final void Function()? onTap;
  final IconData? rightIcon;
  final IconData? leftIcon;
  final double? width;
  final bool isActived;
  final bool fullWidth;

  const BadgeButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.leftIcon,
    this.rightIcon,
    this.width,
    this.isActived = false,
    this.fullWidth = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchWrapper(
      onTap: () {
        if (onTap != null) {
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
            shadows: TouchWrapper.interpolateInnerShadow([
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
            child: Container(
              width: fullWidth ? width : 200,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: const Color(0xFF797CDB)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        if (leftIcon == null) ...[
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: isActived ? const Color(0xFF00FF38) : Colors.transparent,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                          ),
                        ] else ...[
                          Icon(
                            leftIcon,
                            size: 15,
                            color: Colors.white,
                          ),
                        ],
                        const SizedBox(width: 10),
                        Text(
                          label.length > 20 ? '${label.substring(0, 20)}...' : label,
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.98,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Icon(rightIcon, size: 15, color: Colors.white),
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
