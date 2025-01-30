import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/screen/detail/body_of_detail_screen_widget.dart';

import '../../provider/detail/bookmark_icon_provider.dart';
import '../../provider/detail/tourism_detail_provider.dart';
import '../../static/tourism_detail_result_state.dart';
import 'bookmark_icon_widget.dart';

class DetailScreen extends StatefulWidget {
  final int tourismId;

  const DetailScreen({
    super.key,
    required this.tourismId,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  @override
  void initState() {
    super.initState();
    // Run immediately in the micro task queue
    // Future.microtask(() {
    //   context.read<TourismDetailProvider>().fetchTourismDetail(widget.tourismId);
    // });

    // Wait until tree stack built then proceed to fetch data
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<TourismDetailProvider>()
          .fetchTourismDetail(widget.tourismId);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tourism Detail"),
        actions: [
          ChangeNotifierProvider(
            create: (context) => BookmarkIconProvider(),
            child: Consumer<TourismDetailProvider>(
              builder: (context, value, child) {
                return switch (value.resultState) {
                  TourismDetailLoadedState(data: var tourism) =>
                      BookmarkIconWidget(tourism: tourism),
                  _ => const SizedBox(),
                };
              },
            ),
          ),
        ],
      ),
      body: Consumer<TourismDetailProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            TourismDetailLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            TourismDetailLoadedState(data: var tourism) =>
                BodyOfDetailScreenWidget(tourism: tourism),
            TourismDetailErrorState(error: var message) => Center(
              child: Text(message),
            ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
