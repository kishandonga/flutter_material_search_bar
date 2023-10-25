import 'dart:async';

import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';

/// [showMaterialSearchBarDialog] using given parameters
/// [BuildContext] need to pass context of the current widget
/// [TextField] textField provide in the [showMaterialSearchBarDialog] for search query
/// [Widget] provide back button widget at left side
/// [Widget] provide clear button widget at right side
/// [Alignment] provider animation starting alignment default it is [Alignment.center]
/// [int] provide animationDuration value default value it is 300
/// [Color] color for the search bar color, default value is [colorScheme.primary]
/// [EdgeInsetsGeometry] contentPadding default value is 0.0
/// [double] toolbarHeight for the search bar height, default value is [kToolbarHeight]
/// [double] statusBarHeight for the search bar height, default value is [padding.top]
Future<void> showMaterialSearchBarDialog(
  BuildContext context, {
  required TextField textField,
  Widget? backButton,
  Widget? clearButton,
  Alignment? alignment,
  double? statusBarHeight,
  double? toolbarHeight,
  int? animationDuration,
  Color? color,
  EdgeInsetsGeometry contentPadding = EdgeInsets.zero,
}) async {
  final sbHeight = statusBarHeight ?? MediaQuery.of(context).padding.top;
  final abHeight = toolbarHeight ?? kToolbarHeight;
  final animDuration = animationDuration ?? 300;
  final align = alignment ?? Alignment.center;

  showGeneralDialog(
    barrierColor: Colors.transparent,
    barrierDismissible: false,
    transitionDuration: Duration(milliseconds: animDuration),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Material(
        clipBehavior: Clip.antiAlias,
        color: color ?? Theme.of(context).colorScheme.primary,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: sbHeight,
            ),
            SizedBox(
              height: abHeight,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: contentPadding,
                  child: Row(
                    children: [
                      backButton ?? const SizedBox.shrink(),
                      Expanded(
                        child: textField,
                      ),
                      clearButton ?? const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return Align(
        alignment: Alignment.topCenter,
        child: CircularRevealAnimation(
          animation: anim1,
          centerAlignment: align,
          child: child,
        ),
      );
    },
  );
}
