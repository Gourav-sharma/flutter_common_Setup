import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'form_event.dart';
import 'form_state.dart';


class FormBloc extends Bloc<FormuiEvent, FormUiState> {
  final formKey = GlobalKey<FormState>();

  FormBloc() : super(FormUiState()) {

    on<FirstNameEvent>(_firstnameChanged);
    on<LastNameEvent>(_lastnameChanged);
    on<PasswordValidationEvent>(_passwordChanged);
    on<ConfirmPasswordValidationEvent>(_confirmPasswordChanged);
    on<EmailValidationEvent>(_emailChanged);
    on<OnPasswordTap>(_passwordTap);
    on<ConfirmPasswordTapEvent>(_confirmPasswordTap);
    on<UnfocusEvent>(_unFocus);

  }


  void _firstnameChanged(FirstNameEvent event, Emitter<FormUiState> emit) {
    emit(state.copyWith(firstName: event.value));
  }

  void _lastnameChanged(LastNameEvent event, Emitter<FormUiState> emit) {
    emit(state.copyWith(lastName: event.value));
  }

  void _passwordChanged(PasswordValidationEvent event, Emitter<FormUiState> emit) {
    emit(state.copyWith(password: event.value));
  }

  void _confirmPasswordChanged(ConfirmPasswordValidationEvent event, Emitter<FormUiState> emit) {
    emit(state.copyWith(confirmPassword: event.value));
  }

  void _emailChanged(EmailValidationEvent event, Emitter<FormUiState> emit) {
    emit(state.copyWith(email: event.value));
  }

  void _passwordTap(OnPasswordTap event, Emitter<FormUiState> emit) {
    emit(state.copyWith(isPasswordVisible: event.showPassword));
  }
  void _confirmPasswordTap(ConfirmPasswordTapEvent event, Emitter<FormUiState> emit) {
    emit(state.copyWith(isConfirmPasswordVisible: event.showConfirmPassword));
  }


  void _unFocus(UnfocusEvent event, Emitter<FormUiState> emit) {

    state.emailFocusNode.unfocus();
    state.passwordFocusNode.unfocus();
    state.confirmPasswordFocusNode.unfocus();
    state.firstNameFocusNode.unfocus();
    state.lastNameFocusNode.unfocus();
  }

  @override
  Future<void> close() {
    state.emailFocusNode.dispose();
    state.passwordFocusNode.dispose();
    state.confirmPasswordFocusNode.dispose();
    state.firstNameFocusNode.dispose();
    state.lastNameFocusNode.dispose();
    return super.close();
  }

}
