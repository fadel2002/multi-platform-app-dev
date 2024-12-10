import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
      color: Colors.white, // Set the icon color here
    ),
    leading: IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () {
        Fluttertoast.showToast(
          msg: "Menu clicked",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      },
    ),
  );
}