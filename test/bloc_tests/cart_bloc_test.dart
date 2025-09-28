import 'package:flutter_test/flutter_test.dart';
import 'package:food_order_workflow/blocs/cart/cart_bloc.dart';
import 'package:food_order_workflow/blocs/cart/cart_event.dart';
import 'package:food_order_workflow/blocs/cart/cart_state.dart';
import 'package:food_order_workflow/models/menu_item.dart';

void main() {
  late CartBloc cartBloc;

  // Sample menu items for testing
  final pizza = MenuItem(
    id: 'm1',
    name: 'Cheese Pizza',
    description: 'Delicious cheese pizza',
    price: 50.0,
    imageUrl: 'https://example.com/pizza.jpg',
    restaurantId: 'r1',
  );

  final burger = MenuItem(
    id: 'm2',
    name: 'Veggie Burger',
    description: 'Healthy veggie burger',
    price: 70.0,
    imageUrl: 'https://example.com/burger.jpg',
    restaurantId: 'r2',
  );

  setUp(() {
    cartBloc = CartBloc();
  });

  tearDown(() {
    cartBloc.close();
  });

  group('CartBloc Tests', () {
    test('Initial state should be empty', () {
      expect(cartBloc.state.items, isEmpty);
      expect(cartBloc.state.restaurantId, isNull);
    });

    test('AddItem adds a new item to the cart', () {
      cartBloc.add(AddItem(pizza));

      expectLater(
        cartBloc.stream,
        emitsInOrder([
          predicate<CartState>(
            (state) =>
                state.items.length == 1 &&
                state.items.first.item.id == pizza.id &&
                state.items.first.quantity == 1 &&
                state.restaurantId == 'r1',
          ),
        ]),
      );
    });

    test('AddItem increases quantity if item already exists', () {
      cartBloc.add(AddItem(pizza));
      cartBloc.add(AddItem(pizza));

      expectLater(
        cartBloc.stream,
        emitsThrough(
          predicate<CartState>(
            (state) =>
                state.items.length == 1 && state.items.first.quantity == 2,
          ),
        ),
      );
    });

    test('RemoveItem removes item from cart', () async {
      cartBloc.add(AddItem(pizza));
      await Future.delayed(Duration.zero);
      cartBloc.add(RemoveItem(pizza.id));

      expectLater(
        cartBloc.stream,
        emitsThrough(predicate<CartState>((state) => state.items.isEmpty)),
      );
    });

    test('ChangeQuantity updates item quantity', () async {
      cartBloc.add(AddItem(pizza));
      await Future.delayed(Duration.zero);
      cartBloc.add(ChangeQuantity(pizza.id, 5));

      expectLater(
        cartBloc.stream,
        emitsThrough(
          predicate<CartState>((state) => state.items.first.quantity == 5),
        ),
      );
    });

    test('ClearCart empties the cart', () async {
      cartBloc.add(AddItem(pizza));
      await Future.delayed(Duration.zero);
      cartBloc.add(ClearCart());

      expectLater(
        cartBloc.stream,
        emitsThrough(predicate<CartState>((state) => state.items.isEmpty)),
      );
    });

    test('AddItem from different restaurant is ignored', () async {
      cartBloc.add(AddItem(pizza));
      await Future.delayed(Duration.zero);

      // Capture current state after adding pizza
      final initialState = cartBloc.state;

      // Try adding item from different restaurant
      cartBloc.add(AddItem(burger));
      await Future.delayed(Duration.zero);

      // Verify state is unchanged
      expect(cartBloc.state.items.length, 1);
      expect(cartBloc.state.restaurantId, 'r1');
      expect(cartBloc.state, equals(initialState));
    });
  });
}
