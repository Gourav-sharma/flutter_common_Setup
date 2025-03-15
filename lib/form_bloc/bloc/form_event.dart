import 'package:flutter/material.dart';

abstract class FormuiEvent {}

class FormInitEvent extends FormuiEvent {

  final BuildContext context;
  FormInitEvent({
    required this.context});

}

class FirstNameEvent extends FormuiEvent {
  final String value;

  FirstNameEvent(this.value);
}

class LastNameEvent extends FormuiEvent {
  final String value;

  LastNameEvent(this.value);
}

class PasswordValidationEvent extends FormuiEvent {
  final String value;

  PasswordValidationEvent(this.value);
}

class ConfirmPasswordValidationEvent extends FormuiEvent {
  final String value;

  ConfirmPasswordValidationEvent(this.value);
}

class EmailValidationEvent extends FormuiEvent {
  final String value;

  EmailValidationEvent(this.value);
}

class OnPasswordTap extends FormuiEvent {
  final bool showPassword;
  OnPasswordTap({this.showPassword = true});
}

class ConfirmPasswordTapEvent extends FormuiEvent {
  final bool showConfirmPassword;
  ConfirmPasswordTapEvent({this.showConfirmPassword = true});
}

class UnfocusEvent extends FormuiEvent {}

