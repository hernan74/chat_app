part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class OnValidaCamposEvent extends LoginEvent {
  final String email;
  final String password;

  OnValidaCamposEvent(this.email, this.password);
}

class OnInitLoginEvent extends LoginEvent {}

class OnLoginEvent extends LoginEvent {
  final String email;
  final String password;

  OnLoginEvent(this.email, this.password);
}

class OnLogoutEvent extends LoginEvent {}

class OnRegisterEvent extends LoginEvent {
  final String nombre;
  final String email;
  final String password;

  OnRegisterEvent(this.nombre, this.email, this.password);
}

class OnRenewTokenEvent extends LoginEvent {}
