import 'package:flutter/material.dart';

import './slide_animation.dart';

class SlideAnimationWidget extends StatefulWidget {
  final Widget widgetToAnimate;
  final int index;
  final int itemCount;

  const SlideAnimationWidget({Key? key, required this.widgetToAnimate, required this.index, required this.itemCount})
      : super(key: key);

  @override
  _SlideAnimationWidgetState createState() => _SlideAnimationWidgetState();
}

class _SlideAnimationWidgetState extends State<SlideAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideAnimation(
        position: widget.index,
        itemCount: widget.itemCount,
        slideDirection: SlideDirection.fromBottom,
        animationController: _animationController,
        child: widget.widgetToAnimate);
  }
}
