import 'package:equatable/equatable.dart';

import 'address.dart';

class OrderItem extends Equatable {
  final String id;
  final String name;
  final int quantity;
  final double price;

  const OrderItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
  });

  double get subtotal => price * quantity;

  @override
  List<Object?> get props => [id, name, quantity, price];
}

class Order extends Equatable {
  final String id;
  final String restaurantId;
  final List<OrderItem> items;
  final double total;
  final String status;
  final Address deliveryAddress;
  final String paymentMethod;

  const Order({
    required this.id,
    required this.restaurantId,
    required this.items,
    required this.total,
    required this.status,
    required this.deliveryAddress,
    required this.paymentMethod,
  });

  @override
  List<Object?> get props => [
    id,
    restaurantId,
    items,
    total,
    status,
    deliveryAddress,
    paymentMethod,
  ];
}
