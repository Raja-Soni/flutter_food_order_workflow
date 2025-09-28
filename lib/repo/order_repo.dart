import '../models/address.dart';
import '../models/order.dart';

abstract class OrderRepository {
  Future<Order> placeOrder({
    required String restaurantId,
    required List<OrderItem> items,
    required Address address,
    required String paymentMethod,
  });
}
