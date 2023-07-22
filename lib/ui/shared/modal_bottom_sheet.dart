import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ModalBottomSheet<T> extends StatefulWidget {
  final Widget child;

  const ModalBottomSheet({Key? key, required this.child}) : super(key: key);

  @override
  State<ModalBottomSheet> createState() => ModalBottomSheetState();
}

class ModalBottomSheetState<T> extends State<ModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Material(
      child: Container(
        color: const Color(0xFFffffff),
        child: Stack(
          children: [
            Container(
              width: 142,
              height: 4,
              margin: EdgeInsets.only(
                left: size.width / 2 - 71,
                top: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF5E4B94),
                    Color(0xFF5E4B94),
                  ],
                ),
              ),
            ),
            widget.child,
          ],
        ),
      ),
    );
  }
}

Future<void> openModalBottomSheet<T>({
  required BuildContext context,
  required Widget child,
}) async {
  await showCupertinoModalBottomSheet(
    bounce: true,
    expand: false,
    context: context,
    useRootNavigator: true,
    topRadius: const Radius.circular(20),
    duration: const Duration(milliseconds: 300),
    barrierColor: const Color.fromARGB(255, 126, 126, 126).withOpacity(0.7),
    builder: (context) => ModalBottomSheet<T>(child: child),
  );
}
