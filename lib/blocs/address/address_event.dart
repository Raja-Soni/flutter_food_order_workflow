import 'package:equatable/equatable.dart';

import '../../models/address.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object?> get props => [];
}

class SelectAddress extends AddressEvent {
  final Address address;

  const SelectAddress(this.address);

  @override
  List<Object?> get props => [address];
}

class ClearAddress extends AddressEvent {}
