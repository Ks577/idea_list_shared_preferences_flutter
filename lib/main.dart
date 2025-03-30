import 'package:flutter/material.dart';
import 'package:idea_list_shared_pref/screens/idea_screen.dart';
import 'package:idea_list_shared_pref/screens/list_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: const ScrollBehavior(),
      routes: {
        '/': (context) => const ListScreen(),
        '/Idea': (context) => const IdeaScreen(),
      },
      initialRoute: '/',
    ),
  );
}
