import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_order_workflow/blocs/checkout/checkout_bloc.dart';
import 'package:food_order_workflow/error/error.dart';
import 'package:food_order_workflow/models/address.dart';
import 'package:food_order_workflow/models/cart_item.dart';
import 'package:food_order_workflow/models/menu_item.dart';
import 'package:food_order_workflow/models/order.dart';
import 'package:food_order_workflow/repo/order_repo.dart';
import 'package:mocktail/mocktail.dart';

// Mock repository
class MockOrderRepository extends Mock implements OrderRepository {}

// Fallback classes for mocktail
class FakeOrderItem extends Fake implements OrderItem {}

class FakeAddress extends Fake implements Address {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeOrderItem());
    registerFallbackValue(FakeAddress());
  });

  late CheckoutBloc checkoutBloc;
  late MockOrderRepository repository;
  late Address testAddress;
  late List<CartItem> cartItems;
  late List<OrderItem> orderItems;

  setUp(() {
    repository = MockOrderRepository();
    checkoutBloc = CheckoutBloc(repository: repository);

    final pizza = MenuItem(
      id: 'p1',
      name: 'Cheese Pizza',
      description: 'Delicious cheese pizza',
      price: 50.0,
      imageUrl: 'https://via.placeholder.com/150',
      restaurantId: 'r1',
    );

    cartItems = [CartItem(item: pizza, quantity: 2)];

    // Convert CartItem → OrderItem
    orderItems = cartItems
        .map(
          (c) => OrderItem(
            id: c.item.id,
            name: c.item.name,
            price: c.item.price,
            quantity: c.quantity,
          ),
        )
        .toList();

    testAddress = Address(
      street: '123 Main St',
      city: 'Test City',
      id: '',
      state: '',
      zipCode: '',
    );
  });

  tearDown(() {
    checkoutBloc.close();
  });

  group('CheckoutBloc Tests', () {
    blocTest<CheckoutBloc, CheckoutState>(
      'emits [CheckoutLoading, CheckoutSuccess] on successful order',
      build: () {
        final order = Order(
          id: 'o1',
          restaurantId: 'r1',
          items: orderItems,
          paymentMethod: 'COD',
          total: 100.0,
          status: '',
          deliveryAddress: testAddress,
        );

        when(
          () => repository.placeOrder(
            restaurantId: any(named: 'restaurantId'),
            items: any(named: 'items'),
            address: any(named: 'address'),
            paymentMethod: any(named: 'paymentMethod'),
          ),
        ).thenAnswer((_) async => order);

        return checkoutBloc;
      },
      act: (bloc) => bloc.add(
        PlaceOrder(
          restaurantId: 'r1',
          items: orderItems,
          address: testAddress,
          paymentMethod: 'COD',
        ),
      ),
      expect: () => [
        isA<CheckoutLoading>(),
        isA<CheckoutSuccess>().having((s) => s.order.id, 'order.id', 'o1'),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'emits [CheckoutLoading, CheckoutFailure] when AppException is thrown',
      build: () {
        when(
          () => repository.placeOrder(
            restaurantId: any(named: 'restaurantId'),
            items: any(named: 'items'),
            address: any(named: 'address'),
            paymentMethod: any(named: 'paymentMethod'),
          ),
        ).thenThrow(AppException('Payment failed'));
        return checkoutBloc;
      },
      act: (bloc) => bloc.add(
        PlaceOrder(
          restaurantId: 'r1',
          items: orderItems,
          address: testAddress,
          paymentMethod: 'UPI',
        ),
      ),
      expect: () => [
        isA<CheckoutLoading>(),
        isA<CheckoutFailure>().having(
          (f) => f.message,
          'message',
          'Payment failed',
        ),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'emits [CheckoutLoading, CheckoutFailure] on unknown error',
      build: () {
        when(
          () => repository.placeOrder(
            restaurantId: any(named: 'restaurantId'),
            items: any(named: 'items'),
            address: any(named: 'address'),
            paymentMethod: any(named: 'paymentMethod'),
          ),
        ).thenThrow(Exception('Unexpected error'));
        return checkoutBloc;
      },
      act: (bloc) => bloc.add(
        PlaceOrder(
          restaurantId: 'r1',
          items: orderItems,
          address: testAddress,
          paymentMethod: 'Card',
        ),
      ),
      expect: () => [
        isA<CheckoutLoading>(),
        isA<CheckoutFailure>().having(
          (f) => f.message,
          'message',
          contains('Something went wrong'),
        ),
      ],
    );
  });
}
