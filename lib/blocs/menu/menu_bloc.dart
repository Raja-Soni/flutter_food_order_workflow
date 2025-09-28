import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../error/error.dart';
import '../../models/menu_item.dart';
import '../../repo/restaurant_repo.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final RestaurantRepository repository;

  MenuBloc({required this.repository}) : super(MenuInitial()) {
    on<FetchMenu>((event, emit) async {
      emit(MenuLoading());
      try {
        final items = await repository.fetchMenuForRestaurant(
          event.restaurantId,
        );
        emit(MenuLoaded(items));
      } on AppException catch (e) {
        emit(MenuError(e.message));
      } catch (_) {
        emit(const MenuError('Failed to load menu'));
      }
    });
  }
}
