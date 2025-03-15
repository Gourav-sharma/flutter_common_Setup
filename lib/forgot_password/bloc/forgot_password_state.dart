class ForgotPasswordState {

  bool? loader;

  ForgotPasswordState({this.loader});

  ForgotPasswordState copyWith({
    bool? loader,
  }) {
    return ForgotPasswordState(
      loader: loader ?? this.loader,
    );
  }

}
