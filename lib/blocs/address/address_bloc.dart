import 'package:flutter_bloc/flutter_bloc.dart';

import 'address_event.dart';
import 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressEmpty()) {
    on<SelectAddress>((event, emit) {
      emit(AddressSelected(event.address));
    });

    on<ClearAddress>((event, emit) {
      emit(AddressEmpty());
    });
  }
}
