import 'package:flutter/material.dart';

Future push(context, page, {bool replace = false}) {
  if (replace) {
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  }

  return Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

bool pop<T extends Object>(BuildContext context, [T result]) {
  return Navigator.pop(context);
}
