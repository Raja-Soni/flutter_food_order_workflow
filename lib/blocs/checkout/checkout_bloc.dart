import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../error/error.dart';
import '../../models/address.dart';
import '../../models/order.dart';
import '../../repo/order_repo.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final OrderRepository repository;

  CheckoutBloc({required this.repository}) : super(CheckoutInitial()) {
    on<PlaceOrder>((event, emit) async {
      emit(CheckoutLoading());
      try {
        final order = await repository.placeOrder(
          restaurantId: event.restaurantId,
          items: event.items,
          address: event.address,
          paymentMethod: event.paymentMethod,
        );
        emit(CheckoutSuccess(order));
      } on AppException catch (e) {
        emit(CheckoutFailure(e.message));
      } catch (_) {
        emit(const CheckoutFailure('Something went wrong, please try again.'));
      }
    });
  }
}
