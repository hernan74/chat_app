import 'package:chat_app/bloc/chat/chat_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_app/bloc/login/login_bloc.dart';
import 'package:chat_app/bloc/status_server/server_status_bloc.dart';
import 'package:chat_app/bloc/usuario/usuario_bloc.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/widget/loading_widget.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/widget/item_lista_usuarios_widget.dart';

import 'package:chat_app/helpers/helpers.dart' as estilo;

class UsuariosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);

    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) => (current is OnLogoutState),
      listener: (_, state) {
        print('Se disparo el listener para logout');
        Navigator.pushReplacementNamed(context, 'login');
      },
      child: BlocListener<ChatBloc, ChatState>(
        listenWhen: (previous, current) =>
            (current is OnEstablecerReceptorState),
        listener: (_, state) async {
          await Navigator.pushNamed(context, 'chat');

          BlocProvider.of<ChatBloc>(context).add(OnInitChatEvent());
        },
        child: Scaffold(
          appBar: AppBar(
            title: BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (previous, current) =>
                  (current is OnLoginState || current is OnRenewTokenState),
              builder: (_, state) {
                BlocProvider.of<UsuarioBloc>(context, listen: false)
                    .add(OnListaUsuariosEvent());
                return Text(state.nombre);
              },
            ),
            centerTitle: true,
            backgroundColor: estilo.colorPrimarioUno.withOpacity(0.9),
            elevation: 1,
            leading: IconButton(
              icon: Icon(Icons.logout),
              onPressed: () =>
                  BlocProvider.of<LoginBloc>(context).add(OnLogoutEvent()),
            ),
            actions: [
              BlocBuilder<ServerStatusBloc, ServerStatusState>(
                buildWhen: (previous, current) => (current is OnStatusChange),
                builder: (_, state) {
                  print('Se redibuja el boton de estado conexion');
                  return IconButton(
                      icon: Icon(
                        state.serverStatus == ServerStatus.Online
                            ? Icons.cloud_done_outlined
                            : Icons.cloud_off,
                        color: state.serverStatus == ServerStatus.Online
                            ? Colors.blue
                            : Colors.redAccent,
                      ),
                      onPressed: null);
                },
              ),
            ],
          ),
          body: Container(
            child: BlocBuilder<UsuarioBloc, UsuarioState>(
              buildWhen: (previous, current) =>
                  (current is OnObtenerUsuariosState),
              builder: (context, state) {
                if (state.msError == null || state.msError.isEmpty) {
                  _refreshController.refreshCompleted();
                  return SmartRefresher(
                    controller: _refreshController,
                    enablePullDown: true,
                    header: WaterDropHeader(
                      complete: Icon(
                        Icons.check,
                        color: Colors.blue,
                      ),
                      waterDropColor: Colors.blue,
                    ),
                    onRefresh: () => _cargarUsuario(context),
                    child: LoadingWidget(
                      estado: (!state.isLoading),
                      child: _ListaUsuarios(usuarios: state?.usuarios ?? []),
                    ),
                  );
                } else {
                  return Center(
                    child: Text(state.msError),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  void _cargarUsuario(BuildContext context) async {
    BlocProvider.of<UsuarioBloc>(context, listen: false)
        .add(OnListaUsuariosEvent());
  }
}

class _ListaUsuarios extends StatelessWidget {
  const _ListaUsuarios({
    Key key,
    @required this.usuarios,
  }) : super(key: key);

  final List<Usuario> usuarios;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: usuarios.length,
      itemBuilder: (_, i) {
        return ItemListaUsuariosWidget(
          usuario: usuarios[i],
          onTap: () {
            BlocProvider.of<ChatBloc>(context).add(OnEstablecerReceptorEvent(
                BlocProvider.of<LoginBloc>(context).state.usuario,
                usuarios[i]));
          },
        );
      },
    );
  }
}
