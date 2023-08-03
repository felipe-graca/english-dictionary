import 'package:english_dictionary/ui/shared/inner_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  final String? label;
  final String hint;
  final TextInputType keyboardType;
  final dynamic suffixIcon;
  final bool autovalidate;
  final bool isDisabled;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;
  final bool obscureText;
  final int maxLines;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onTapIcon;
  final bool hasError;
  final String? errorMessage;
  final bool wasSubmitted;
  final double radius;
  final bool addEmptySpace;
  final String? initialValue;

  const CustomTextField({
    Key? key,
    this.label,
    this.hint = '',
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.autovalidate = false,
    this.isDisabled = false,
    this.controller,
    this.onChanged,
    this.textInputAction = TextInputAction.done,
    this.focusNode,
    this.onEditingComplete,
    this.obscureText = false,
    this.maxLines = 1,
    this.maxLength,
    this.onTapIcon,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.hasError = false,
    this.errorMessage,
    this.wasSubmitted = false,
    this.radius = 5,
    this.addEmptySpace = false,
    this.initialValue,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _LightTextFieldState();
}

class _LightTextFieldState extends State<CustomTextField> {
  bool looseFocus = false;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && !looseFocus) {
        setState(() {
          looseFocus = true;
        });
      } else {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.hasError && (looseFocus || widget.wasSubmitted);

    const height = 50.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null || widget.addEmptySpace)
          Padding(
            padding: const EdgeInsets.only(bottom: 4, left: 4),
            child: Text(widget.label ?? ' '),
          ),
        Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(widget.radius),
            child: InnerShadow(
              shadows: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
              child: Container(
                height: height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(widget.radius),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: TextFormField(
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    key: widget.key,
                    textInputAction: widget.textInputAction,
                    onEditingComplete: widget.onEditingComplete,
                    readOnly: widget.isDisabled,
                    controller: widget.controller,
                    focusNode: _focusNode,
                    keyboardType: widget.keyboardType,
                    onChanged: widget.onChanged,
                    maxLines: widget.maxLines,
                    obscureText: widget.obscureText,
                    textCapitalization: widget.textCapitalization,
                    inputFormatters: widget.inputFormatters,
                    textAlignVertical: TextAlignVertical.center,
                    maxLength: widget.maxLength,
                    initialValue: widget.initialValue,
                    decoration: InputDecoration(
                      hintText: widget.hint,
                      hintStyle: const Text('').style,
                      suffixIcon: widget.suffixIcon,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      border: InputBorder.none,
                      isCollapsed: true,
                      counterText: '',
                    ),
                    style: Text(
                      '',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.15,
                        color: const Color.fromARGB(255, 102, 102, 102),
                      ),
                    ).style,
                    cursorColor: Colors.black.withOpacity(0.2),
                    cursorHeight: 18,
                  ),
                ),
              ),
            ),
          ),
          if (hasError) ...[
            SizedBox(
                height: height,
                width: double.maxFinite,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                  ),
                )),
            if (widget.errorMessage != null)
              Container(
                height: height + 20,
                padding: const EdgeInsets.only(left: 4),
                alignment: Alignment.bottomLeft,
                child: Text(widget.errorMessage!),
              ),
          ],
        ]),
      ],
    );
  }
}
