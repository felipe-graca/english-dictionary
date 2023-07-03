import 'package:flutter/material.dart';

class BottomNavigatorItem extends StatelessWidget {
  final IconData icon;
  final Function() onTap;
  final bool isActive;
  const BottomNavigatorItem({
    super.key,
    required this.icon,
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
                width: 60,
                height: 60,
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
                child: Center(
                  child: Icon(
                    icon,
                    size: 40,
                    color: const Color(0xFF797CDB),
                  ),
                ),
              ),
            )
          : Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(10),
              child: Center(
                child: SizedBox(
                  child: Icon(
                    icon,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
    );
  }
}
