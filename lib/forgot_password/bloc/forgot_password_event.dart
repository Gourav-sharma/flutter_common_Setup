abstract class ForgotPasswordEvent {}

class InitEvent extends ForgotPasswordEvent {}

class ForgotPasswordSubmitEvent extends ForgotPasswordEvent {
  final String? email;
  ForgotPasswordSubmitEvent({required this.email});

}