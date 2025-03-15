import 'package:flutter/cupertino.dart';

abstract class SignupEvent {}

class InitEvent extends SignupEvent {
  final BuildContext context;

  InitEvent({required this.context});
}

class SubmitEvent extends SignupEvent {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? confirmPassword;

  SubmitEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

class UsernameChangedEvent extends SignupEvent {
  final String value;

  UsernameChangedEvent(this.value);
}

class PasswordChangedEvent extends SignupEvent {
  final String value;

  PasswordChangedEvent(this.value);
}

class EmailChangedEvent extends SignupEvent {
  final String value;

  EmailChangedEvent(this.value);
}
