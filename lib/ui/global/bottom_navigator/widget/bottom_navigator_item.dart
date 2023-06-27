import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigatorItem extends StatelessWidget {
  final String iconPath;
  final Function() onTap;
  final bool isActive;
  const BottomNavigatorItem({
    super.key,
    required this.iconPath,
    required this.onTap,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: isActive
          ? Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFCDCDCD).withOpacity(0.25),
                      blurRadius: 4,
                      offset: const Offset(-2, 2),
                    ),
                    BoxShadow(
                      color: const Color(0xFFCDCDCD).withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(2, -2),
                    ),
                  ],
                ),
                child: Center(child: SvgPicture.asset(iconPath, height: 40, width: 40)),
              ),
            )
          : Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(10),
              child: Center(
                child: SizedBox(
                  child: SvgPicture.asset(iconPath, height: 30, width: 30),
                ),
              ),
            ),
    );
  }
}
