import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> buildDropdownItems(List<String> types) {
  return types
      .map(
        (type) => DropdownMenuItem(
      value: type,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(type),
      ),
    ),
  ).toList();
}