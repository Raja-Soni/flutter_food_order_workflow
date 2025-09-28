import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String description;
  final String address;
  final String imageUrl;

  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name, description, address, imageUrl];
}
