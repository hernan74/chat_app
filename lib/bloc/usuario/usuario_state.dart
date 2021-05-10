part of 'usuario_bloc.dart';

@immutable
class UsuarioState {
  final List<Usuario> usuarios;

  final bool isLoading;

  final bool ok;
  final String msError;

  UsuarioState({
    this.usuarios,
    this.isLoading = false,
    this.ok = false,
    this.msError = '',
  });

  UsuarioState copyWith(
          {List<Usuario> usuarios, bool isLoading, bool ok, String msError}) =>
      UsuarioState(
        usuarios: usuarios ?? this.usuarios,
      );

  UsuarioState initState() => UsuarioState();
}

class OnObtenerUsuariosState extends UsuarioState {
  OnObtenerUsuariosState({UsuarioState state})
      : super(
            usuarios: state.usuarios,
            isLoading: state.isLoading,
            msError: state.msError,
            ok: state.ok);
}
