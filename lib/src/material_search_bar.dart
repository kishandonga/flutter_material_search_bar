import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';

import 'material_search_bar_controller.dart';

//TODO: offset impl
//TODO: animation curve impl
//TODO: is search bar visible method impl
class MaterialSearchBar extends StatefulWidget implements PreferredSizeWidget {
  final MaterialSearchBarController controller;
  final AppBar appBar;
  final TextField textField;
  final double? toolbarHeight;
  final Color? color;
  final Widget? backButton;
  final Widget? clearButton;
  final Alignment? alignment;
  final int? animationDuration;
  final EdgeInsetsGeometry contentPadding;

  /// create [MaterialSearchBar] using given parameters
  /// [MaterialSearchBarController] is required parameter to handle [MaterialSearchBar] visibility using toggleSearchBar() method
  /// [AppBar] setup app bar inside then [MaterialSearchBar]
  /// [TextField] textField provide in the [MaterialSearchBar] for search query
  /// [Widget] provide back button widget at left side
  /// [Widget] provide clear button widget at right side
  /// [Alignment] provider animation starting alignment default it is [Alignment.center]
  /// [int] provide animationDuration value default value it is 300
  /// [Color] color for the search bar color, default value is [colorScheme.primary]
  /// [double] toolbarHeight for the search bar height, default value is [kToolbarHeight]
  /// [EdgeInsetsGeometry] contentPadding default value is 8.0
  const MaterialSearchBar({
    required this.controller,
    required this.appBar,
    required this.textField,
    this.backButton,
    this.clearButton,
    this.alignment,
    this.toolbarHeight,
    this.animationDuration,
    this.color,
    this.contentPadding = const EdgeInsets.all(8.0),
    super.key,
  });

  @override
  State<MaterialSearchBar> createState() => _MaterialSearchAppBar();

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);
}

class _MaterialSearchAppBar extends State<MaterialSearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animationDuration ?? 300),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );
    widget.controller.register(() async {
      await _toggleAnimation();
    });
    super.initState();
  }

  _toggleAnimation() async {
    if (animationController.status == AnimationStatus.forward ||
        animationController.status == AnimationStatus.completed) {
      await animationController.reverse();
    } else {
      await animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.appBar,
        CircularRevealAnimation(
          animation: animation,
          centerAlignment: widget.alignment ?? Alignment.center,
          child: Material(
            clipBehavior: Clip.antiAlias,
            color: widget.color ?? Theme.of(context).colorScheme.primary,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: widget.toolbarHeight ?? kToolbarHeight,
                child: Padding(
                  padding: widget.contentPadding,
                  child: Row(
                    children: [
                      widget.backButton ?? const SizedBox.shrink(),
                      Expanded(
                        child: widget.textField,
                      ),
                      widget.clearButton ?? const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
