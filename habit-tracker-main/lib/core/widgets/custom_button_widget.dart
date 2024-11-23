import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/text_styles.dart';

class CustomButtonWidget extends StatelessWidget {
  final String title;
  final BorderRadius? borderRadius;
  final Function() onTap;

  const CustomButtonWidget(
      {super.key, required this.title, required this.onTap, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            padding: kPaddingMedium,
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? kBorderRadiusCircular)),
        onPressed: onTap,
        child:
            Text(title, style: TextStyles.h3.copyWith(color: kOnPrimaryColor)));
  }
}
