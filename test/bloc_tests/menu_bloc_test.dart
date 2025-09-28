import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_order_workflow/blocs/menu/menu_bloc.dart';
import 'package:food_order_workflow/error/error.dart';
import 'package:food_order_workflow/models/menu_item.dart';
import 'package:food_order_workflow/repo/restaurant_repo.dart';
import 'package:mocktail/mocktail.dart';

// Mock repository
class MockRestaurantRepository extends Mock implements RestaurantRepository {}

// Fallback class for mocktail
class FakeMenuItem extends Fake implements MenuItem {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeMenuItem());
  });

  late MenuBloc menuBloc;
  late MockRestaurantRepository repository;

  final sampleMenu = [
    MenuItem(
      id: 'p1',
      name: 'Cheese Pizza',
      description: 'Delicious cheese pizza',
      price: 50.0,
      imageUrl: 'https://via.placeholder.com/150',
      restaurantId: 'r1',
    ),
    MenuItem(
      id: 'p2',
      name: 'Chicken Pizza',
      description: 'Spicy chicken pizza',
      price: 70.0,
      imageUrl: 'https://via.placeholder.com/150',
      restaurantId: 'r1',
    ),
  ];

  setUp(() {
    repository = MockRestaurantRepository();
    menuBloc = MenuBloc(repository: repository);
  });

  tearDown(() {
    menuBloc.close();
  });

  group('MenuBloc Tests', () {
    blocTest<MenuBloc, MenuState>(
      'emits [MenuLoading, MenuLoaded] when menu is fetched successfully',
      build: () {
        when(
          () => repository.fetchMenuForRestaurant('r1'),
        ).thenAnswer((_) async => sampleMenu);
        return menuBloc;
      },
      act: (bloc) => bloc.add(const FetchMenu('r1')),
      expect: () => [
        isA<MenuLoading>(),
        isA<MenuLoaded>().having((s) => s.items.length, 'items.length', 2),
      ],
    );

    blocTest<MenuBloc, MenuState>(
      'emits [MenuLoading, MenuError] when AppException is thrown',
      build: () {
        when(
          () => repository.fetchMenuForRestaurant('r1'),
        ).thenThrow(AppException('Failed to fetch'));
        return menuBloc;
      },
      act: (bloc) => bloc.add(const FetchMenu('r1')),
      expect: () => [
        isA<MenuLoading>(),
        isA<MenuError>().having((e) => e.message, 'message', 'Failed to fetch'),
      ],
    );

    blocTest<MenuBloc, MenuState>(
      'emits [MenuLoading, MenuError] on unknown exception',
      build: () {
        when(
          () => repository.fetchMenuForRestaurant('r1'),
        ).thenThrow(Exception('Unknown error'));
        return menuBloc;
      },
      act: (bloc) => bloc.add(const FetchMenu('r1')),
      expect: () => [
        isA<MenuLoading>(),
        isA<MenuError>().having(
          (e) => e.message,
          'message',
          'Failed to load menu',
        ),
      ],
    );
  });
}
