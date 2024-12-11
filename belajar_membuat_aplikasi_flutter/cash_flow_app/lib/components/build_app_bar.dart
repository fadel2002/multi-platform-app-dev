import 'package:flutter/material.dart';

AppBar buildAppBar(String title) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(
          color: Colors.white,
          fontSize: 20
      ),
    ),
    backgroundColor: Colors.blue[800],
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  );
}