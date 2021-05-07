import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:meta/meta.dart';

import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/services/auth_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState());

  final _storage = new FlutterSecureStorage();
  final authService = new AuthService();

  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'key');
    return token;
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is OnValidaCamposEvent) {
      yield* _onValidarCampos(event);
    } else if (event is OnLoginEvent) {
      yield* _onLogin(event);
    } else if (event is OnLogoutEvent) {
      await _storage.delete(key: 'token');
      yield OnLogoutState();
    } else if (event is OnRegisterEvent) {
      yield* _onRegister(event);
    } else if (event is OnInitLoginEvent) {
      yield LoginState();
    } else if (event is OnRenewTokenEvent) {
      yield* _onRenewToken(event);
    }
  }

  Stream<LoginState> _onValidarCampos(OnValidaCamposEvent event) async* {
    final validacion = validarCampos(event.email, event.password);
    yield OnValidacionState(state: state.copyWith(valido: validacion));
  }

  Stream<LoginState> _onLogin(OnLoginEvent event) async* {
    yield OnLoginState(
        state: state.copyWith(
            isLoading: true,
            valido: false,
            email: event.email,
            password: event.password));
    LoginResponse respuesta =
        await authService.login(event.email, event.password);
    if (respuesta == null) return;
    if (respuesta.ok) {
      await _storage.write(key: 'token', value: respuesta.token);
    }
    yield OnLoginState(
        state: state.copyWith(
            isLoading: false,
            valido: respuesta.ok,
            msError: respuesta.msg,
            nombre: respuesta.usuario?.nombre,
            usuario: respuesta.usuario));
  }

  bool validarCampos(String email, String passWord) {
    print('ValidarCampos: $email $passWord');
    bool camposOk = false;
    if (email != null) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);
      if (regExp.hasMatch(email)) {
        camposOk = true;
      }
    }
    if (camposOk) {
      camposOk = false;
      if (passWord != null) {
        if (passWord.length >= 6) {
          camposOk = true;
        }
      }
    }
    return camposOk;
  }

  Stream<LoginState> _onRegister(OnRegisterEvent event) async* {
    yield OnRegisterState(
        state: state.copyWith(isLoading: true, valido: false));
    final validacion = validarCampos(event.email, event.password) &&
        (event.nombre != null && event.nombre.trim().isNotEmpty);
    if (!validacion) {
      yield OnRegisterState(
          state: state.copyWith(
              isLoading: false,
              valido: validacion,
              msError: 'Complete todos los campos de forma correcta!'));
      return;
    }
    LoginResponse respuesta =
        await authService.register(event.nombre, event.email, event.password);
    yield OnRegisterState(
        state: state.copyWith(
            isLoading: false,
            valido: respuesta.ok,
            msError: respuesta.msg,
            usuario: respuesta.usuario));
  }

  Stream<LoginState> _onRenewToken(OnRenewTokenEvent event) async* {
    yield OnRenewTokenState(
        state: state.copyWith(isLoading: true, valido: false));
    final LoginResponse respuesta =
        await authService.renovarJWT(await _storage.read(key: 'token'));
    print(await _storage.read(key: 'token'));
    if (respuesta == null) {
      yield OnRenewTokenState(
          state: state.copyWith(
              isLoading: false,
              valido: false,
              msError: 'Error de conexion con el servidor'));
    }
    if (respuesta.ok) {
      _storage.write(key: 'token', value: respuesta.token);
    }
    yield OnRenewTokenState(
        state: state.copyWith(
            isLoading: false,
            valido: respuesta.ok,
            msError: respuesta.msg,
            nombre: respuesta.usuario?.nombre,
            usuario: respuesta.usuario));
  }
}
