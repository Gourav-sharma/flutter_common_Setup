import 'package:flutter/material.dart';

abstract class LoginEvent {}

class InitEvent extends LoginEvent {

  final BuildContext context;
  InitEvent({required this.context});

}

class EmailChangedEvent extends LoginEvent {
  final String value;
  EmailChangedEvent(this.value);

}

class PasswordChangedEvent extends LoginEvent {
  final String value;
  PasswordChangedEvent(this.value);
}

class LoginSubmittedEvent extends LoginEvent {
  final String? password;
  final String? email;

  LoginSubmittedEvent(
    {
    required this.email,
    required this.password
    }
      );

}