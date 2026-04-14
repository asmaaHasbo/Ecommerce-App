import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  pushNamed(String routeName, {Object? arguments}) {
    Navigator.pushNamed(this, routeName, arguments: arguments);
  }

  pushReplacementNamed(String routeName, {Object? arguments}) {
    Navigator.pushReplacementNamed(this, routeName, arguments: arguments);
  }

  pop<T extends Object?>([T? result]) {
    Navigator.pop(this, result);
  }

  pushNamedAndRemoveUntil(String routeName, {Object? arguments}) {
    Navigator.pushNamedAndRemoveUntil(
      this,
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }
}

extension StringExtensions on String? {
  bool isStringNullOrEmpty() {
    //this refers to the string on which the method is called
    return this == null || this == '';
  }
}
