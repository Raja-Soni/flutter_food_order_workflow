import 'package:equatable/equatable.dart';

import '../../models/address.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object?> get props => [];
}

// No address selected
class AddressEmpty extends AddressState {}

// Address selected
class AddressSelected extends AddressState {
  final Address address;

  const AddressSelected(this.address);

  @override
  List<Object?> get props => [address];
}
