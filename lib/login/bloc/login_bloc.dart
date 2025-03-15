import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_structure/app_utils/app_logs.dart';
import 'package:bloc_structure/app_utils/common_util_methods.dart';
import 'package:flutter/material.dart';
import '../../api_calling/api_client.dart';
import '../../api_calling/api_repo.dart';
import '../../api_calling/constant.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final formKey = GlobalKey<FormState>();

  LoginBloc() : super(LoginState()) {
    on<InitEvent>(_init);
    on<LoginSubmittedEvent>(_loginSubmitted);
  }

  void _init(InitEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(context: event.context));
  }


  Future<void> _loginSubmitted(LoginSubmittedEvent event, Emitter<LoginState> emit) async {
    CommonUtilMethods.closeKeyboard(state.context!);
    emit(state.copyWith(loader: true));
    AppLogs.showInfoLogs("${event.email}");

    var request = {
      "email": event.email,
      "password": event.password,
      "deviceToken": "",
      "deviceType": Platform.isAndroid ? 1 : 2,
      "userType": 2
    };
    try {
       await ApiRepository.apiCall(
              loginAPI,
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
