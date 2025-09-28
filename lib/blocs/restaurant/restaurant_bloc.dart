import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../error/error.dart';
import '../../models/restaurant.dart';
import '../../repo/restaurant_repo.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository repository;

  RestaurantBloc({required this.repository}) : super(RestaurantInitial()) {
    on<FetchRestaurants>((event, emit) async {
      emit(RestaurantLoading());
      try {
        final restaurants = await repository.fetchRestaurants();
        emit(RestaurantLoaded(restaurants));
      } on AppException catch (e) {
        emit(RestaurantError(e.message));
      } catch (_) {
        emit(const RestaurantError('Failed to load restaurants'));
      }
    });
  }
}
