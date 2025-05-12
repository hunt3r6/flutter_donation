import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class CustomFadePage<T> extends CustomTransitionPage<T> {
  CustomFadePage({required super.child, required LocalKey super.key})
    : super(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      );
}
