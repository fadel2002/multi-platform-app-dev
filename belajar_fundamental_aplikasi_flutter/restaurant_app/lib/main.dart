import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/api/api_service.dart';
import 'data/local/local_database_service.dart';
import 'provider/connection/connectivity_provider.dart';
import 'provider/detail/restaurant_detail_provider.dart';
import 'provider/favorite/local_database_provider.dart';
import 'provider/main/index_nav_provider.dart';
import 'provider/notification/local_notification_provider.dart';
import 'provider/restaurant/restaurant_list_provider.dart';
import 'provider/restaurant/restaurant_post_review_provider.dart';
import 'provider/restaurant/restaurant_search_provider.dart';
import 'provider/settings/settings_provider.dart';
import 'screen/detail/restaurant_detail_screen.dart';
import 'screen/main/main_screen.dart';
import 'data/local/shared_preferences_service.dart';
import 'services/local_notification_service.dart';
import 'static/navigation_route.dart';
import 'style/theme/restaurant_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => LocalNotificationService()
            ..init()
            ..configureLocalTimeZone(),
        ),
        ChangeNotifierProvider(
          create: (context) => IndexNavProvider(),
        ),
        Provider(
          create: (context) => SharedPreferencesService(prefs),
        ),
        Provider(
          create: (context) => ApiServices(),
        ),
        ChangeNotifierProvider(
            create: (_) => ConnectivityProvider()
        ),
        ChangeNotifierProvider(
          create: (context) => LocalNotificationProvider(
            context.read<LocalNotificationService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingsProvider(
            context.read<SharedPreferencesService>(),
          ),
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
          create: (context) => RestaurantDetailProvider(
            context.read<ApiServices>(),
            context.read<ConnectivityProvider>(),
          ),
        ),
        Provider(
          create: (context) => LocalDatabaseService(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalDatabaseProvider(
            context.read<LocalDatabaseService>(),
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
    final themeProvider = context.watch<SettingsProvider>();

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
