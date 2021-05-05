part of 'usuario_bloc.dart';

@immutable
class UsuarioState {
  final Usuario usuario;
  final List<Usuario> usuarios;

  UsuarioState({this.usuarios, this.usuario});

  UsuarioState copyWith({
    usuario,
    usuarios,
    chat,
  }) =>
      UsuarioState(
        usuario: usuario ?? this.usuario,
        usuarios: usuarios ?? this.usuarios,
      );

  UsuarioState initState() => UsuarioState();
}
