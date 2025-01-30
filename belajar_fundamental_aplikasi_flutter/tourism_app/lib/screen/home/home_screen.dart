import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/screen/home/tourism_card_widget.dart';
import 'package:tourism_app/static/navigation_route.dart';

import '../../provider/home/tourism_list_provider.dart';
import '../../static/tourism_list_result_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    // Run immediately in the micro task queue
    // Future.microtask(() {
    //   context.read<TourismListProvider>().fetchTourismList();
    // });

    // Wait until tree stack built then proceed to fetch data
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<TourismListProvider>()
          .fetchTourismList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tourism List"),
      ),
      body: Consumer<TourismListProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            TourismListLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            TourismListLoadedState(data: var tourismList) => ListView.builder(
              itemCount: tourismList.length,
              itemBuilder: (context, index) {
                final tourism = tourismList[index];

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
            TourismListErrorState(error: var message) => Center(
              child: Text(message),
            ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
