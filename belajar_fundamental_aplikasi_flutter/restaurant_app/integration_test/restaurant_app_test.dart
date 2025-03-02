import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:belajar_fundamental_aplikasi_flutter/data/api/api_service.dart';
import 'package:belajar_fundamental_aplikasi_flutter/data/local/shared_preferences_service.dart';
import 'package:belajar_fundamental_aplikasi_flutter/main.dart';
import 'package:belajar_fundamental_aplikasi_flutter/provider/connection/connectivity_provider.dart';
import 'package:belajar_fundamental_aplikasi_flutter/provider/main/index_nav_provider.dart';
import 'package:belajar_fundamental_aplikasi_flutter/provider/restaurant/restaurant_list_provider.dart';
import 'package:belajar_fundamental_aplikasi_flutter/provider/restaurant/restaurant_search_provider.dart';
import 'package:belajar_fundamental_aplikasi_flutter/provider/settings/settings_provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Restaurant list and search functionality", (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
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
        ],
        child: const MyApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(ListView), findsOneWidget);

    await tester.enterText(find.byType(TextField), "Kafe");

    await tester.pumpAndSettle();

    expect(find.text("Kafe"), findsWidgets);
  });
}