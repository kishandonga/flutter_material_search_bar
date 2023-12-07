import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';

import 'flutter_material_search_bar_controller.dart';

//TODO: offset impl
//TODO: animation curve impl

///A widget to show [MaterialSearchBar], it is [StatefulWidget] widget and implements [PreferredSizeWidget] for the size estimation
///based on the circular revel animation here used stack overlay for the [MaterialSearchBar]
class MaterialSearchBar extends StatefulWidget implements PreferredSizeWidget {
  /// controller [MaterialSearchBarController] required to use utility methods, this is required param
  final MaterialSearchBarController controller;

  /// use appBar [AppBar] same as used in the [Scaffold], this is required param
  final AppBar appBar;

  /// pass textField [TextField] for the search view and this is required param
  final TextField textField;

  ///if your [AppBar] customized then pass updated toolbar height
  final double? toolbarHeight;

  /// use color [Color] param for the color of the search bar view
  final Color? color;

  /// to show back button [backButton] use back button widget [Widget]
  final Widget? backButton;

  /// to show clear button [clearButton] use clear button widget [Widget]
  final Widget? clearButton;

  /// starting alignment [Alignment] of the animation, for the possible values refer [Alignment], default it is [Alignment.center]
  final Alignment? alignment;

  ///[int] provide animationDuration value default value it is 300
  final int? animationDuration;

  /// [EdgeInsetsGeometry] contentPadding default value is [EdgeInsets.zero]
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
  /// [EdgeInsetsGeometry] contentPadding default value is [EdgeInsets.zero]
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
    this.contentPadding = EdgeInsets.zero,
    super.key,
  });

  @override
  State<MaterialSearchBar> createState() => _MaterialSearchAppBar();

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);
}

class _MaterialSearchAppBar extends State<MaterialSearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController animController;
  late Animation<double> animation;

  @override
  void initState() {
    animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animationDuration ?? 300),
    );
    animation = CurvedAnimation(
      parent: animController,
      curve: Curves.easeIn,
    );
    widget.controller.addListener(() async {
      await _toggleAnimation();
    });
    super.initState();
  }

  _toggleAnimation() async {
    if (animController.status == AnimationStatus.forward ||
        animController.status == AnimationStatus.completed) {
      await animController.reverse();
      widget.controller.isSearchBarVisible = false;
    } else {
      await animController.forward();
      widget.controller.isSearchBarVisible = true;
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
