import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/bookmark/local_database_provider.dart';
import '../../static/navigation_route.dart';
import '../home/tourism_card_widget.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  void initState() {
    Future.microtask((){
      context.read<LocalDatabaseProvider>().loadAllTourism();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmark List"),
      ),
      body: Consumer<LocalDatabaseProvider>(
        builder: (context, value, child) {
          final bookmarkList = value.tourismList ?? [];
          return switch (bookmarkList.isNotEmpty) {
            true => ListView.builder(
              itemCount: bookmarkList.length,
              itemBuilder: (context, index) {
                final tourism = bookmarkList[index];
                return TourismCard(
                  tourism: tourism,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      NavigationRoute.detailRoute.name,
                      arguments: tourism.id,
                    );
                  },
                );
              },
            ),
            _ => const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("No Bookmarked"),
                ],
              ),
            ),
          };
        }
      ),
    );
  }
}

