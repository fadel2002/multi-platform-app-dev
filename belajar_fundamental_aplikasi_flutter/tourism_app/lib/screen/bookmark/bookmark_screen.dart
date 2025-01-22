import 'package:flutter/material.dart';

import '../../model/tourism.dart';
import '../../static/navigation_route.dart';
import '../home/tourism_card_widget.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmark List"),
      ),
      body: ListView.builder(
        itemCount: bookmarkTourismList.length,
        itemBuilder: (context, index) {
          final tourism = bookmarkTourismList[index];
          return TourismCard(
            tourism: tourism,
            onTap: () {
              Navigator.pushNamed(
                context,
                NavigationRoute.detailRoute.name,
                arguments: tourism,
              );
            },
          );
        },
      ),
    );
  }
}