import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:belajar_fundamental_aplikasi_flutter/data/api/api_service.dart';
import 'package:belajar_fundamental_aplikasi_flutter/provider/connection/connectivity_provider.dart';
import 'package:belajar_fundamental_aplikasi_flutter/provider/restaurant/restaurant_list_provider.dart';
import 'package:belajar_fundamental_aplikasi_flutter/data/model/restaurant.dart';
import 'package:belajar_fundamental_aplikasi_flutter/data/model/restaurant_list_response.dart';
import 'package:belajar_fundamental_aplikasi_flutter/static/restaurant_list_result_state.dart';

class MockApiServices extends Mock implements ApiServices {}
class MockConnectivityProvider extends Mock implements ConnectivityProvider {}

void main() {
  late RestaurantListProvider provider;
  late MockApiServices mockApiServices;
  late MockConnectivityProvider mockConnectivityProvider;

  setUp(() {
    mockApiServices = MockApiServices();
    mockConnectivityProvider = MockConnectivityProvider();
    provider = RestaurantListProvider(mockApiServices, mockConnectivityProvider);
  });

  group('RestaurantListProvider Tests', () {
    test('State should initially be None', () {
      expect(provider.resultState, isA<RestaurantListNoneState>());
    });

    test('Should return list of restaurants when API fetch is successful', () async {
      when(() => mockConnectivityProvider.hasInternetConnection).thenReturn(true);

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

      final mockResponse = RestaurantListResponse(
        error: false,
        message: "Success",
        count: 2,
        restaurants: mockRestaurants,
      );

      when(() => mockApiServices.getRestaurantList()).thenAnswer((_) async => mockResponse);

      await provider.fetchRestaurantList();

      expect(provider.resultState, isA<RestaurantListLoadedState>());
      expect((provider.resultState as RestaurantListLoadedState).data, mockRestaurants);
      expect((provider.resultState as RestaurantListLoadedState).data.length, 2);
    });

    test('Should return error state when API fetch fails', () async {
      when(() => mockConnectivityProvider.hasInternetConnection).thenReturn(true);
      when(() => mockApiServices.getRestaurantList()).thenThrow(Exception("API Error"));

      await provider.fetchRestaurantList();

      expect(provider.resultState, isA<RestaurantListErrorState>());
      expect((provider.resultState as RestaurantListErrorState).error, contains("Exception"));
    });

    test('Should return error state when there is no internet', () async {
      when(() => mockConnectivityProvider.hasInternetConnection).thenReturn(false);

      await provider.fetchRestaurantList();

      expect(provider.resultState, isA<RestaurantListErrorState>());
      expect((provider.resultState as RestaurantListErrorState).error, "noInternetConnection");
    });
  });
}