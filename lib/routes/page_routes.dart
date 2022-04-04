import 'package:flutter/material.dart';

class PageRoutes extends PageRouteBuilder<dynamic> {
  PageRoutes(
      {required this.child,
      RouteSettings? settings,
      this.direction = AxisDirection.left})
      : super(
          // transitionDuration: const Duration(seconds: 1),
          pageBuilder: (context, animation, secondaryAnimation) => child,
          settings: settings,
        );

  final Widget child;

  final AxisDirection direction;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    //  return ScaleTransition(
    //   scale: animation,
    //   child: child
    // );
    return SlideTransition(
      position: Tween<Offset>(begin: getBeginOffset(), end: Offset.zero)
          .animate(animation),
      child: child,
    );
  }

  Offset getBeginOffset() {
    switch (direction) {
      case AxisDirection.up:
        return const Offset(0, 1);
      case AxisDirection.down:
        return const Offset(0, -1);
      case AxisDirection.right:
        return const Offset(-1, 0);
      case AxisDirection.left:
        return const Offset(1, 0);
    }
  }
}
