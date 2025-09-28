part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();
  @override
  List<Object?> get props => [];
}

class FetchMenu extends MenuEvent {
  final String restaurantId;
  const FetchMenu(this.restaurantId);

  @override
  List<Object?> get props => [restaurantId];
}
