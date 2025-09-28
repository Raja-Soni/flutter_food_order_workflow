import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/cart_item.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState.initial()) {
    on<AddItem>((event, emit) {
      final items = List<CartItem>.from(state.items);

      // If restaurant is different, ignore or reset cart
      if (state.restaurantId != null &&
          state.restaurantId != event.item.restaurantId) {
        return;
      }

      final index = items.indexWhere((i) => i.item.id == event.item.id);
      if (index >= 0) {
        final oldItem = items[index];
        items[index] = CartItem(
          item: oldItem.item,
          quantity: oldItem.quantity + 1,
        );
      } else {
        items.add(CartItem(item: event.item, quantity: 1));
      }

      emit(state.copyWith(items: items, restaurantId: event.item.restaurantId));
    });

    on<RemoveItem>((event, emit) {
      final items = state.items
          .where((i) => i.item.id != event.itemId)
          .toList();
      final restId = items.isEmpty ? null : state.restaurantId;
      emit(state.copyWith(items: items, restaurantId: restId));
    });

    on<ChangeQuantity>((event, emit) {
      final items = state.items.map((i) {
        if (i.item.id == event.itemId) {
          return CartItem(item: i.item, quantity: event.quantity);
        }
        return i;
      }).toList();
      emit(state.copyWith(items: items));
    });

    on<ClearCart>((event, emit) {
      emit(CartState.initial());
    });
  }
}
