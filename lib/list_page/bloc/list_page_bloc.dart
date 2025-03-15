import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/list_page_event.dart';
import '../bloc/list_page_state.dart';

class ListPageBloc extends Bloc<ListPageEvent, ListPageState> {
  ListPageBloc() : super(ListPageState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<ListPageState> emit) async {
    emit(state.clone());
  }
}
