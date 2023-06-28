import 'package:english_dictionary/ui/shared/custom_vibration.dart';
import 'package:flutter/material.dart';

class TouchWrapper extends StatefulWidget {
  final Widget Function(double value) builder;
  final void Function()? onTap;
  final void Function()? onLongPressed;
  final bool? isChecked;
  final bool isDisabled;

  const TouchWrapper({
    Key? key,
    required this.builder,
    required this.onTap,
    this.onLongPressed,
    this.isChecked,
    this.isDisabled = false,
  }) : super(key: key);

  static List<BoxShadow> interpolateInnerShadow(List<BoxShadow> shadows, double value) {
    return shadows
        .map((e) => BoxShadow(
              color: e.color,
              blurRadius: _remapFromZero(value, e.blurRadius),
              offset: Offset(_remapFromZero(value, e.offset.dx), _remapFromZero(value, e.offset.dy)),
              spreadRadius: _remapFromZero(value, e.spreadRadius),
            ))
        .toList();
  }

  static List<BoxShadow> interpolateOuterShadow(List<BoxShadow> shadows, double value, [double? opacity]) {
    return shadows
        .map((e) => BoxShadow(
              color: opacity == null ? e.color : e.color.withOpacity(opacity),
              blurRadius: _remapToZero(value, e.blurRadius),
              offset: Offset(_remapToZero(value, e.offset.dx), _remapToZero(value, e.offset.dy)),
              spreadRadius: _remapToZero(value, e.spreadRadius),
            ))
        .toList();
  }

  @override
  State<TouchWrapper> createState() => _TouchWrapperState();
}

class _TouchWrapperState extends State<TouchWrapper> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeOutQuart,
  );

  late final isCheckable = widget.isChecked != null;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isCheckable) {
      if (widget.isChecked! && _animation.value == 0) {
        _animationController.forward();
        setState(() {});
      } else if (!widget.isChecked! && _animation.value == 1) {
        _animationController.reverse();
        setState(() {});
      }
    }
    return GestureDetector(
      onTapDown: (_) {
        if (widget.isChecked != true && !widget.isDisabled) {
          _animationController.forward();
        }
      },
      onTapUp: (_) {
        if (widget.isDisabled) {
          return;
        }

        if (!isCheckable || widget.isChecked!) {
          _animationController.reverse();
        }
        CustomVibration.mediumImpact();
        widget.onTap!();
      },
      onTapCancel: () {
        if (widget.isDisabled) {
          return;
        }

        if (!isCheckable || !widget.isChecked!) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
      },
      onLongPress: widget.onLongPressed == null
          ? null
          : () {
              if (widget.isDisabled) {
                return;
              }

              _animationController.reverse();

              CustomVibration.mediumImpact();
              widget.onLongPressed!();
            },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) {
          return widget.builder(_animation.value);
        },
      ),
    );
  }
}

double _remapFromZero(double value, double stop2) {
  const start1 = 0.0;
  const stop1 = 1.0;
  const start2 = 0.0;

  final outgoing = start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1));

  return outgoing;
}

double _remapToZero(double value, double start2) {
  const start1 = 0.0;
  const stop1 = 1.0;
  const stop2 = 0.0;

  final outgoing = start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1));

  return outgoing;
}
