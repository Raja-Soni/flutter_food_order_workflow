import 'package:equatable/equatable.dart';

import '../../models/menu_item.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

class AddItem extends CartEvent {
  final MenuItem item;
  const AddItem(this.item);

  @override
  List<Object?> get props => [item];
}

class RemoveItem extends CartEvent {
  final String itemId;
  const RemoveItem(this.itemId);

  @override
  List<Object?> get props => [itemId];
}

class ChangeQuantity extends CartEvent {
  final String itemId;
  final int quantity;
  const ChangeQuantity(this.itemId, this.quantity);

  @override
  List<Object?> get props => [itemId, quantity];
}

class ClearCart extends CartEvent {}
