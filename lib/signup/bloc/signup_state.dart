import 'package:flutter/material.dart';

class SignupState {
  bool? loader;
  BuildContext? context;
  String? username;
  String? password;
  String? email;
  bool? isPassword ;

  SignupState({
    this.context,
    this.loader,
    this.username,
    this.password,
    this.email,
    this.isPassword = true ,
  });

  SignupState copyWith({
    BuildContext? context,
    bool? loader,
    String? username,
    String? password,
    String? email,
    bool? isPasswordVisible,
   }) {
    return SignupState(
      context: context ?? this.context,
      loader: loader ?? this.loader,
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      isPassword: isPasswordVisible ?? isPassword,
    );
  }
}
