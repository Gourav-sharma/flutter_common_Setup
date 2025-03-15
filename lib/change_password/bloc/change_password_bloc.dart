import 'package:flutter_bloc/flutter_bloc.dart';

import 'change_password_event.dart';
import 'change_password_state.dart';

class ChangepasswordBloc extends Bloc<ChangepasswordEvent, ChangepasswordState> {
  ChangepasswordBloc() : super(const ChangepasswordState(name: "")) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<ChangepasswordState> emit) async {
    emit(state.copyWith(name: "init"));
  }
}
