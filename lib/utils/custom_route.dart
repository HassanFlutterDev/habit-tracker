import 'package:flutter/material.dart';

// class MyCustomRoute<T> extends MaterialPageRoute<T> {
//   MyCustomRoute({required WidgetBuilder builder, RouteSettings? settings})
//       : super(builder: builder, settings: settings);
//
//   @override
//   Widget buildTransitions(BuildContext context, Animation<double> animation,
//       Animation<double> secondaryAnimation, Widget child) {
//     // if (settings.isInitialRoute)
//     //   return child;
//
//     return FadeTransition(opacity: animation, child: child);
//   }
// }

class MyCustomRoute<T> extends PageRoute<T> {
  MyCustomRoute(this.child);

  @override
  // TODO: implement barrierColor
  Color get barrierColor => Colors.black;

  @override
  String get barrierLabel => "";

  final Widget child;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);
}
