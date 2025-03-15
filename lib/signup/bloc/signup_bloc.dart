import 'dart:io';

import 'package:bloc_structure/signup/bloc/signup_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_structure/api_calling/api_repo.dart';
import 'package:bloc_structure/app_utils/app_logs.dart';
import 'package:flutter/material.dart';
import '../../api_calling/api_client.dart';
import '../../api_calling/constant.dart';
import '../../form_bloc/bloc/form_bloc.dart';
import '../../app_utils/common_util_methods.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {

  final formKey = GlobalKey<FormState>();
  FormBloc formuiBloc = FormBloc();
  SignupBloc() : super(SignupState()) {
    on<InitEvent>(_init);
    on<SubmitEvent>(_submit);
  }

  void _init(InitEvent event, Emitter<SignupState> emit) async {
    emit(state.copyWith(context: event.context));

  }


  void _submit(SubmitEvent event, Emitter<SignupState> emit) async {
    CommonUtilMethods.closeKeyboard(state.context!);
    AppLogs.showInfoLogs('First Name: ${event.firstName},'
        ' Last Name: ${event.lastName}, '
        ' Password: ${event.password}, '
        ' Confirm Password: ${event.confirmPassword}, '
        'Email: ${event.email}');
    emit(state.copyWith(loader: true));
    var request = {
      "firstName": event.firstName,
      "lastName": event.lastName,
      "email": event.email,
      "password": event.password,
      "confirmPassword": event.confirmPassword,
      "deviceType": Platform.isAndroid ? 1 : 2,
      "userType": 2
    };
    try {
      final response = await ApiRepository.apiCall(loginAPI, RequestType.post, data: request);
      if(response.statusCode==200){
        AppLogs.showApiSuccessLogs(loginAPI,"${response.message}");
      }
    } catch (e) {
      CommonUtilMethods.showSnackBar(message: " ${e.toString()}");
      AppLogs.showErrorLogs("$e");
    }
    emit(state.copyWith(loader: false));
  }


}
