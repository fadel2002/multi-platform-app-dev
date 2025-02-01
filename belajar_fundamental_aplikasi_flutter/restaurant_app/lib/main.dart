import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/api/api_service.dart';
import 'provider/connection/connectivity_provider.dart';
import 'provider/detail/favorite_list_provider.dart';
import 'provider/detail/restaurant_detail_provider.dart';
import 'provider/main/index_nav_provider.dart';
import 'provider/restaurant/restaurant_list_provider.dart';
import 'provider/restaurant/restaurant_post_review_provider.dart';
import 'provider/restaurant/restaurant_search_provider.dart';
import 'provider/settings/settings_provider.dart';
import 'screen/detail/restaurant_detail_screen.dart';
import 'screen/main/main_screen.dart';
import 'static/navigation_route.dart';
import 'style/theme/restaurant_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => IndexNavProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingsProvider(),
        ),
        Provider(
          create: (context) => ApiServices(),
        ),
        ChangeNotifierProvider(
            create: (_) => ConnectivityProvider()
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantSearchProvider(
            context.read<ApiServices>(),
            context.read<ConnectivityProvider>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(
            context.read<ApiServices>(),
            context.read<ConnectivityProvider>()
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantPostReviewProvider(
              context.read<ApiServices>(),
              context.read<ConnectivityProvider>()
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantDetailProvider(
            context.read<ApiServices>(),
            context.read<ConnectivityProvider>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      title: 'Restaurant App',
      theme: RestaurantTheme.lightTheme,
      darkTheme: RestaurantTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const MainScreen(),
        NavigationRoute.detailRoute.name: (context) => RestaurantDetailScreen(
          restaurantId: ModalRoute.of(context)?.settings.arguments as String,
        ),
      },
    );
  }
}
