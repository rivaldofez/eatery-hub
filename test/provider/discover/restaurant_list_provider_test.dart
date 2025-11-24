import 'package:eateryhub/data/api/api_services.dart';
import 'package:eateryhub/data/model/restaurant.dart';
import 'package:eateryhub/data/model/restaurant_list_response.dart';
import 'package:eateryhub/provider/discover/restaurant_list_provider.dart';
import 'package:eateryhub/static/base_result_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

class MockApiServices extends Mock implements ApiServices {}

void main() {
  late MockApiServices mockApiServices;
  late RestaurantListProvider restaurantListProvider;

  RestaurantListResponse errorResponse = RestaurantListResponse(
    error: true,
    message: "Invalid data",
    restaurants: [],
  );

  RestaurantListResponse successResponse = RestaurantListResponse(
    error: false,
    message: "Success",
    restaurants: [
      Restaurant(
        id: "rqdv5juczeskfw1e867",
        name: "Melting Pot",
        description:
            "A modern fusion restaurant offering a blend of Asian and Western dishes.",
        pictureId: "14",
        city: "Medan",
        rating: 4.2,
      ),
      Restaurant(
        id: "uduxdh5fsjzdksal1e12",
        name: "Kafe Kita",
        description:
            "Cozy coffee shop with a variety of local snacks and specialty coffee.",
        pictureId: "25",
        city: "Jakarta",
        rating: 4.5,
      ),
      Restaurant(
        id: "yefr3p9fskw02jad112",
        name: "Rumah Makan Sederhana",
        description:
            "Traditional Indonesian food with rich flavors and affordable prices.",
        pictureId: "32",
        city: "Bandung",
        rating: 4.0,
      ),
    ],
  );

  setUp(() {
    mockApiServices = MockApiServices();
    restaurantListProvider = RestaurantListProvider(mockApiServices);
  });

  group("Restaurant List Provider", () {
    test('should return none state when provider initialize', () {
      final initState = restaurantListProvider.resultState;
      expect(initState, isA<NoneState<List<Restaurant>>>());
    });

    test(
      'should return loaded state with value when provider success',
      () async {
        when(
          () => mockApiServices.getRestaurantList(),
        ).thenAnswer((_) async => successResponse);

        await restaurantListProvider.fetchRestaurantList();

        final state = restaurantListProvider.resultState;
        expect(state, isA<LoadedState<List<Restaurant>>>());

        final loadedState = state as LoadedState<List<Restaurant>>;
        expect(loadedState.data, successResponse.restaurants);
      },
    );

    test(
      'should return error state when provider got error response',
      () async {
        when(
          () => mockApiServices.getRestaurantList(),
        ).thenAnswer((_) async => errorResponse);

        await restaurantListProvider.fetchRestaurantList();

        final state = restaurantListProvider.resultState;
        expect(state, isA<ErrorState<List<Restaurant>>>());

        final loadedState = state as ErrorState<List<Restaurant>>;
        expect(loadedState.error, errorResponse.message);
      },
    );

    test('should return error state when provider got exception', () async {
      when(
        () => mockApiServices.getRestaurantList(),
      ).thenThrow(Exception("Failed to initialize"));

      await restaurantListProvider.fetchRestaurantList();

      final state = restaurantListProvider.resultState;
      expect(state, isA<ErrorState<List<Restaurant>>>());
    });
  });
}
