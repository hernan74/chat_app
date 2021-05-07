part of 'login_bloc.dart';

@immutable
class LoginState {
  final Usuario usuario;

  final String nombre;
  final String email;
  final String password;
  final bool isLoading;

  final bool valido;
  final String msError;
  final int codeError;

  LoginState(
      {this.usuario,
      this.nombre,
      this.email,
      this.password,
      this.isLoading = false,
      this.valido = false,
      this.msError = '',
      this.codeError = 0});

  LoginState copyWith(
          {Usuario usuario,
          String nombre,
          String email,
          String password,
          bool isLoading,
          bool valido,
          String msError,
          int codeError}) =>
      LoginState(
          usuario: usuario ?? this.usuario,
          nombre: nombre ?? this.nombre,
          email: email ?? this.email,
          password: password ?? this.password,
          isLoading: isLoading ?? this.isLoading,
          msError: msError ?? this.msError,
          codeError: codeError ?? this.codeError,
          valido: valido ?? this.valido);

  LoginState initState() => LoginState();
}

class OnValidacionState extends LoginState {
  OnValidacionState({LoginState state})
      : super(
            email: state.email,
            password: state.password,
            isLoading: state.isLoading,
            msError: state.msError,
            codeError: state.codeError,
            valido: state.valido);
}

class OnLoginState extends LoginState {
  OnLoginState({LoginState state})
      : super(
            usuario: state.usuario,
            nombre: state.nombre,
            email: state.email,
            password: state.password,
            isLoading: state.isLoading,
            msError: state.msError,
            codeError: state.codeError,
            valido: state.valido);
}

class OnLogoutState extends LoginState {}

class OnRegisterState extends LoginState {
  OnRegisterState({LoginState state})
      : super(
            nombre: state.nombre,
            email: state.email,
            password: state.password,
            isLoading: state.isLoading,
            msError: state.msError,
            codeError: state.codeError,
            valido: state.valido);
}

class OnRenewTokenState extends LoginState {
  OnRenewTokenState({LoginState state})
      : super(
            usuario: state.usuario,
            nombre: state.nombre,
            email: state.email,
            password: state.password,
            isLoading: state.isLoading,
            msError: state.msError,
            codeError: state.codeError,
            valido: state.valido);
}
