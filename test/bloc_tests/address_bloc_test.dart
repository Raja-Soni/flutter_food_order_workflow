import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_order_workflow/blocs/address/address_bloc.dart';
import 'package:food_order_workflow/blocs/address/address_event.dart';
import 'package:food_order_workflow/blocs/address/address_state.dart';
import 'package:food_order_workflow/models/address.dart';

void main() {
  late AddressBloc addressBloc;
  late Address testAddress;

  setUp(() {
    addressBloc = AddressBloc();
    testAddress = Address(
      id: 'a1',
      street: '123 Main St',
      city: 'Test City',
      state: 'Test State',
      zipCode: '12345',
    );
  });

  tearDown(() {
    addressBloc.close();
  });

  group('AddressBloc Tests', () {
    blocTest<AddressBloc, AddressState>(
      'emits [AddressSelected] when SelectAddress is added',
      build: () => addressBloc,
      act: (bloc) => bloc.add(SelectAddress(testAddress)),
      expect: () => [AddressSelected(testAddress)],
    );

    blocTest<AddressBloc, AddressState>(
      'emits [AddressEmpty] when ClearAddress is added',
      build: () => addressBloc,
      act: (bloc) => bloc.add(ClearAddress()),
      expect: () => [AddressEmpty()],
    );
  });
}
