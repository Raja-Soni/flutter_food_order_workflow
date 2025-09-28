part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();
  @override
  List<Object?> get props => [];
}

class PlaceOrder extends CheckoutEvent {
  final String restaurantId;
  final List<OrderItem> items;
  final Address address;
  final String paymentMethod;

  const PlaceOrder({
    required this.restaurantId,
    required this.items,
    required this.address,
    required this.paymentMethod,
  });

  @override
  List<Object?> get props => [restaurantId, items, address, paymentMethod];
}
