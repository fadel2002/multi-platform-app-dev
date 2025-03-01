import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import 'package:belajar_fundamental_aplikasi_flutter/data/model/restaurant.dart';
import 'package:belajar_fundamental_aplikasi_flutter/provider/restaurant/restaurant_list_provider.dart';
import 'package:belajar_fundamental_aplikasi_flutter/provider/restaurant/restaurant_search_provider.dart';
import 'package:belajar_fundamental_aplikasi_flutter/screen/restaurant/restaurant_screen.dart';
import 'package:belajar_fundamental_aplikasi_flutter/static/restaurant_list_result_state.dart';
import 'package:belajar_fundamental_aplikasi_flutter/utils/enums.dart';

class MockRestaurantListProvider extends Mock implements RestaurantListProvider {}
class MockRestaurantSearchProvider extends Mock implements RestaurantSearchProvider {}

void main() {
  late MockRestaurantListProvider mockRestaurantListProvider;
  late MockRestaurantSearchProvider mockRestaurantSearchProvider;

  setUpAll(() {
    HttpOverrides.global = _MockHttpOverrides();
  });

  setUp(() {
    mockRestaurantListProvider = MockRestaurantListProvider();
    mockRestaurantSearchProvider = MockRestaurantSearchProvider();

    when(() => mockRestaurantSearchProvider.isSearching).thenReturn(false);
    when(() => mockRestaurantListProvider.fetchRestaurantList()).thenAnswer((_) async => Future.value());
  });

  Widget createTestWidget() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantListProvider>.value(value: mockRestaurantListProvider),
        ChangeNotifierProvider<RestaurantSearchProvider>.value(value: mockRestaurantSearchProvider),
      ],
      child: const MaterialApp(
        home: RestaurantScreen(),
      ),
    );
  }

  group("RestaurantList Tests", () {
    testWidgets('Displays loading indicator when fetching data', (WidgetTester tester) async {
      when(() => mockRestaurantListProvider.resultState).thenReturn(RestaurantListLoadingState());

      await tester.pumpWidget(createTestWidget());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Displays restaurant list when data is loaded', (WidgetTester tester) async {
      final mockRestaurants = [
        Restaurant(
          id: "1",
          name: "Mock Restaurant 1",
          description: "A great place to eat",
          city: "Mock City",
          pictureId: "mock_pic_1",
          rating: 4.5,
        ),
        Restaurant(
          id: "2",
          name: "Mock Restaurant 2",
          description: "Another great place",
          city: "Mock City 2",
          pictureId: "mock_pic_2",
          rating: 4.2,
        ),
      ];

      when(() => mockRestaurantListProvider.resultState).thenReturn(RestaurantListLoadedState(mockRestaurants));

      await tester.runAsync(() async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
      });

      expect(find.text("Mock Restaurant 1"), findsOneWidget);
      expect(find.text("Mock Restaurant 2"), findsOneWidget);
    });

    testWidgets('Displays error message when API fetch fails', (WidgetTester tester) async {
      when(() => mockRestaurantListProvider.resultState).thenReturn(RestaurantListErrorState(ErrorType.apiFetchError.name));

      await tester.pumpWidget(createTestWidget());

      expect(find.text("Oops, something went wrong. Please try again later."), findsOneWidget);
    });

    testWidgets('Displays error message when there is no internet', (WidgetTester tester) async {
      when(() => mockRestaurantListProvider.resultState).thenReturn(RestaurantListErrorState(ErrorType.noInternetConnection.name));

      await tester.pumpWidget(createTestWidget());

      expect(find.text("No internet connection found. Please check your connection and try again."), findsOneWidget);
    });

    testWidgets('Search bar updates search provider when text is entered', (WidgetTester tester) async {
      when(() => mockRestaurantListProvider.resultState).thenReturn(RestaurantListNoneState());
      when(() => mockRestaurantSearchProvider.fetchRestaurantSearch(any())).thenAnswer((_) async => Future.value());

      await tester.pumpWidget(createTestWidget());

      await tester.enterText(find.byType(TextField), "Pizza");
      verify(() => mockRestaurantSearchProvider.startSearching()).called(1);
      verify(() => mockRestaurantSearchProvider.fetchRestaurantSearch("Pizza")).called(1);
    });
  });
}

class _MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}