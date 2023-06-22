import 'package:flutter/material.dart';

class AlunosListNavigator {
  AlunosListNavigator._();

  static final navigatorKey = GlobalKey<NavigatorState>();
  static NavigatorState get to => navigatorKey.currentState!;
}