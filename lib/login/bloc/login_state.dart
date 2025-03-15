import 'package:flutter/material.dart';

class LoginState {

  BuildContext? context;
  bool? loader;
  String? username;
  String? password;
  bool? isPasswordVisible;

  LoginState({
  this.context,
  this.loader,
  this.username,
  this.password,
  this.isPasswordVisible = true,
});


LoginState copyWith({
  BuildContext? context,
  bool? loader,
  String? username,
  String? password,
  bool? isPasswordVisible,
}) {
  return LoginState(
    context: context ?? this.context,
    loader: loader ?? this.loader,
    username: username ?? this.username,
    password: password ?? this.password,
    isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
  );
}

}
