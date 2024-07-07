import 'package:flutter/material.dart';

void navigate(BuildContext context, Widget screen) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => screen),
  );
}
