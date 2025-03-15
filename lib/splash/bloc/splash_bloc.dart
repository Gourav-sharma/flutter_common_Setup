import 'splash_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../routes/generate_routes.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<SplashState> emit) async {
    Future.delayed(Duration(seconds: 3), () {
      AppRouter.go(AppRouter.loginPage);
    });
  }


}


