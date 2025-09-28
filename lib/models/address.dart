import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String id;
  final String street;
  final String city;
  final String state;
  final String zipCode;

  const Address({
    required this.id,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
  });

  String get formatted => "$street, $city, $state - $zipCode";

  @override
  List<Object?> get props => [id, street, city, state, zipCode];
}
