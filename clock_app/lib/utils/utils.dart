import 'package:flutter/material.dart';
import 'package:clock_app/constants/constants.dart';

extension ClockExtensions on int {
  String toTimeString() {
    if (this < 100) {
      return toString().padLeft(2, '0');
    } else {
      return toString().substring(toString().length - 2);
    }
  }
}

// Widget customButton({
//   required void Function()? onPressed,
//   required Widget? child,
// }) {
//   return
// }

class CustomButton extends ElevatedButton {
  // void Function()? onPressed;
  // void Function()? onLongPress;
  // void Function(bool)? onHover;
  // void Function(bool)? onFocusChange;
  // ButtonStyle? style;
  // FocusNode? focusNode;
  // bool autofocus = false;
  // Clip clipBehavior = Clip.none;
  // MaterialStatesController? statesController;
  // Widget? child;

  const CustomButton({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus = false,
    super.clipBehavior = Clip.none,
    super.statesController,
    required super.child,
  });

  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(40)),
      child: ElevatedButton(
        style: const ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll(CustomColors.secondaryColor),
          textStyle: MaterialStatePropertyAll(
            TextStyle(
                fontSize: 20,
                color: CustomColors.foreground,
                fontFamily: "ubuntu"),
          ),
          fixedSize: MaterialStatePropertyAll(Size(90, 40)),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
