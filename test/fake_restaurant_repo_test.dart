import 'package:flutter_test/flutter_test.dart';
import 'package:food_order_workflow/models/menu_item.dart';
import 'package:food_order_workflow/models/restaurant.dart';
import 'package:food_order_workflow/repo/fake_restaurant_repo.dart';

void main() {
  late FakeRestaurantRepository repository;

  setUp(() {
    repository = FakeRestaurantRepository();
  });

  group('FakeRestaurantRepository Tests', () {
    test('fetchRestaurants returns a list of 3 restaurants', () async {
      final restaurants = await repository.fetchRestaurants();

      expect(restaurants, isA<List<Restaurant>>());
      expect(restaurants.length, 3);

      // Check first restaurant
      expect(restaurants[0].id, 'r1');
      expect(restaurants[0].name, 'Pizza Palace');

      // Check second restaurant
      expect(restaurants[1].id, 'r2');
      expect(restaurants[1].name, 'Burger Hub');

      // Check third restaurant
      expect(restaurants[2].id, 'r3');
      expect(restaurants[2].name, 'Sushi World');
    });

    test(
      'fetchMenuForRestaurant returns correct menu for Pizza Palace',
      () async {
        final menu = await repository.fetchMenuForRestaurant('r1');

        expect(menu, isA<List<MenuItem>>());
        expect(menu.length, greaterThan(0));

        final firstItem = menu.first;
        expect(firstItem.name, 'Cheese Pizza');
        expect(firstItem.restaurantId, 'r1');
        expect(firstItem.price, 50.0);
      },
    );

    test(
      'fetchMenuForRestaurant returns correct menu for Burger Hub',
      () async {
        final menu = await repository.fetchMenuForRestaurant('r2');

        expect(menu, isA<List<MenuItem>>());
        expect(menu.length, greaterThan(0));

        final firstItem = menu.first;
        expect(firstItem.name, 'Veggie Burger');
        expect(firstItem.restaurantId, 'r2');
      },
    );

    test(
      'fetchMenuForRestaurant returns correct menu for Sushi World',
      () async {
        final menu = await repository.fetchMenuForRestaurant('r3');

        expect(menu, isA<List<MenuItem>>());
        expect(menu.length, greaterThan(0));

        final firstItem = menu.first;
        expect(firstItem.name, 'Salmon Sushi');
        expect(firstItem.restaurantId, 'r3');
      },
    );

    test(
      'fetchMenuForRestaurant returns empty list for unknown restaurant',
      () async {
        final menu = await repository.fetchMenuForRestaurant('unknown');
        expect(menu, isEmpty);
      },
    );
  });
}
