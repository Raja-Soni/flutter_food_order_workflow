import 'package:equatable/equatable.dart';

import '../../models/cart_item.dart';

class CartState extends Equatable {
  final List<CartItem> items;
  final String? restaurantId;

  const CartState({required this.items, this.restaurantId});

  factory CartState.initial() => CartState(items: [], restaurantId: null);

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  double get total =>
      items.fold(0.0, (sum, item) => sum + item.item.price * item.quantity);

  CartState copyWith({List<CartItem>? items, String? restaurantId}) {
    return CartState(
      items: items != null ? List.from(items) : List.from(this.items),
      restaurantId: restaurantId ?? this.restaurantId,
    );
  }

  @override
  List<Object?> get props => [items, restaurantId];
}
