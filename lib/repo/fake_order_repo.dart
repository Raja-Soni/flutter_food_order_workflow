import '../models/address.dart';
import '../models/order.dart';
import 'order_repo.dart';

class FakeOrderRepository implements OrderRepository {
  @override
  Future<Order> placeOrder({
    required String restaurantId,
    required List<OrderItem> items,
    required Address address,
    required String paymentMethod,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    final total = items.fold<double>(0, (sum, item) => sum + item.subtotal);

    return Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      restaurantId: restaurantId,
      items: items,
      total: total,
      status: 'Confirmed',
      deliveryAddress: address,
      paymentMethod: paymentMethod,
    );
  }
}
