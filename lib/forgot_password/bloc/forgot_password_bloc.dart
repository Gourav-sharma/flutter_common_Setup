import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_structure/main.dart';
import '../../api_calling/api_client.dart';
import '../../api_calling/api_repo.dart';
import '../../api_calling/constant.dart';
import '../../app_utils/app_logs.dart';
import '../../app_utils/common_util_methods.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordState()) {
    on<InitEvent>(_init);
    on<ForgotPasswordSubmitEvent>(_forgotPasswordSubmit);

  }

  void _init(InitEvent event, Emitter<ForgotPasswordState> emit) async {

  }
  void _forgotPasswordSubmit(ForgotPasswordSubmitEvent event, Emitter<ForgotPasswordState> emit) async {
    CommonUtilMethods.closeKeyboard(navigatorKey.currentState!.context);
    emit(state.copyWith(loader: true));
    AppLogs.showInfoLogs("${event.email}");

    var request = {
      "email": event.email,
      "deviceType": Platform.isAndroid ? 1 : 2,
      "userType": 2
    };
    try {
       await ApiRepository.apiCall(
          forgotPasswordAPI,
          RequestType.post,
          data: request
      );
    } catch (e) {
      CommonUtilMethods.showSnackBar(message: " ${e.toString()}");
      AppLogs.showErrorLogs("$e");
    }
    emit(state.copyWith(loader: false));
  }

}
