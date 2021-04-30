import 'package:flutter/material.dart';

class OpacityAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const OpacityAnimation(
      {@required this.child, this.duration = Duration.zero});

  @override
  _OpacityAnimationState createState() => _OpacityAnimationState();
}

class _OpacityAnimationState extends State<OpacityAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> opacidad;

  @override
  void initState() {
    controller =
        new AnimationController(vsync: this, duration: this.widget.duration);
    opacidad = Tween(begin: 0.0, end: 1.0).animate(this.controller);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();
    return AnimatedBuilder(
      animation: this.controller,
      builder: (BuildContext context, Widget child) {
        return Opacity(
          opacity: this.opacidad.value,
          child: this.widget.child,
        );
      },
    );
  }
}
