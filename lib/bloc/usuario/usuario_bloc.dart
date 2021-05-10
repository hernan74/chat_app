import 'package:chat_app/models/usuarios_response.dart';
import 'package:chat_app/services/usuarios_service.dart';
import 'package:meta/meta.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app/models/usuario.dart';

part 'usuario_event.dart';
part 'usuario_state.dart';

class UsuarioBloc extends Bloc<UsuarioEvent, UsuarioState> {
  UsuarioBloc() : super(UsuarioState());

  final usuarioService = new UsuariosService();

  @override
  Stream<UsuarioState> mapEventToState(UsuarioEvent event) async* {
    if (event is OnListaUsuariosEvent) {
      yield* _onObtenerUsuarios(event);
    }
  }

  Stream<UsuarioState> _onObtenerUsuarios(OnListaUsuariosEvent event) async* {
    yield OnObtenerUsuariosState(
        state: state.copyWith(isLoading: true, ok: false, msError: ''));
    final UsuariosResponse usuarioResponse = await usuarioService.getUsuarios();

    yield OnObtenerUsuariosState(
        state: state.copyWith(
            isLoading: false,
            ok: usuarioResponse.ok,
            msError: usuarioResponse.msg,
            usuarios: usuarioResponse.usuarios));
  }
}
