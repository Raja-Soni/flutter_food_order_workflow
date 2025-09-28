import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_order_workflow/blocs/restaurant/restaurant_bloc.dart';
import 'package:food_order_workflow/error/error.dart';
import 'package:food_order_workflow/models/restaurant.dart';
import 'package:food_order_workflow/repo/restaurant_repo.dart';
import 'package:mocktail/mocktail.dart';

// Mock repository
class MockRestaurantRepository extends Mock implements RestaurantRepository {}

void main() {
  late RestaurantBloc restaurantBloc;
  late MockRestaurantRepository repository;

  final restaurants = [
    const Restaurant(
      id: 'r1',
      name: 'Pizza Palace',
      description: 'Best pizzas in town',
      address: '123 Main St',
      imageUrl: 'https://via.placeholder.com/150',
    ),
    const Restaurant(
      id: 'r2',
      name: 'Burger Hub',
      description: 'Juicy burgers',
      address: '456 Main St',
      imageUrl: 'https://via.placeholder.com/150',
    ),
  ];

  setUp(() {
    repository = MockRestaurantRepository();
    restaurantBloc = RestaurantBloc(repository: repository);
  });

  tearDown(() {
    restaurantBloc.close();
  });

  group('RestaurantBloc Tests', () {
    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantLoaded] when fetch is successful',
      build: () {
        when(
          () => repository.fetchRestaurants(),
        ).thenAnswer((_) async => restaurants);
        return restaurantBloc;
      },
      act: (bloc) => bloc.add(FetchRestaurants()),
      expect: () => [
        isA<RestaurantLoading>(),
        isA<RestaurantLoaded>().having(
          (s) => s.restaurants.length,
          'length',
          2,
        ),
      ],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantError] when AppException occurs',
      build: () {
        when(
          () => repository.fetchRestaurants(),
        ).thenThrow(AppException('Failed to fetch'));
        return restaurantBloc;
      },
      act: (bloc) => bloc.add(FetchRestaurants()),
      expect: () => [
        isA<RestaurantLoading>(),
        isA<RestaurantError>().having(
          (s) => s.message,
          'message',
          'Failed to fetch',
        ),
      ],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantError] when unknown error occurs',
      build: () {
        when(() => repository.fetchRestaurants()).thenThrow(Exception());
        return restaurantBloc;
      },
      act: (bloc) => bloc.add(FetchRestaurants()),
      expect: () => [
        isA<RestaurantLoading>(),
        isA<RestaurantError>().having(
          (s) => s.message,
          'message',
          contains('Failed to load'),
        ),
      ],
    );
  });
}
