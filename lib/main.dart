import 'package:enjoy_plus_hm/pages/tab_bar/index.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
     MaterialApp(
      routes: {
       '/': (context)=> const TabBarPage()
      }
     ),
  );
}
