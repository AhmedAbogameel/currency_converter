import 'package:flutter/material.dart';

import '../../main.dart';

Future<void> pushView(Widget view) {
  return Navigator.of(globalContext).push(MaterialPageRoute(
    builder: (context) => view,
  ));
}