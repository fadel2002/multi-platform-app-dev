import 'package:belajar_fundamental_aplikasi_flutter/data/api/api_service.dart';
import 'package:belajar_fundamental_aplikasi_flutter/provider/detail/favorite_list_provider.dart';
import 'package:belajar_fundamental_aplikasi_flutter/provider/detail/restaurant_detail_provider.dart';
import 'package:belajar_fundamental_aplikasi_flutter/provider/main/index_nav_provider.dart';
import 'package:belajar_fundamental_aplikasi_flutter/provider/restaurant/restaurant_list_provider.dart';
import 'package:belajar_fundamental_aplikasi_flutter/provider/restaurant/restaurant_search_provider.dart';
import 'package:belajar_fundamental_aplikasi_flutter/screen/detail/restaurant_detail_screen.dart';
import 'package:belajar_fundamental_aplikasi_flutter/screen/main/main_screen.dart';
import 'package:belajar_fundamental_aplikasi_flutter/static/navigation_route.dart';
import 'package:belajar_fundamental_aplikasi_flutter/style/theme/restaurant_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => IndexNavProvider(),
        ),
        Provider(
          create: (context) => ApiServices(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantSearchProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantDetailProvider(
            context.read<ApiServices>(),
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
    return MaterialApp(
      title: 'Restaurant App',
      theme: RestaurantTheme.lightTheme,
      darkTheme: RestaurantTheme.darkTheme,
      themeMode: ThemeMode.system,
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
