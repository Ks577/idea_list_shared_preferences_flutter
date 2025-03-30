import 'package:flutter/material.dart';

Widget background() {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/idea.jpeg'),
        fit: BoxFit.cover,
      ),
    ),
  );
}
