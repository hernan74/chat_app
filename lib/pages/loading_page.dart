import 'package:chat_app/bloc/login/login_bloc.dart';
import 'package:chat_app/bloc/status_server/server_status_bloc.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LoginBloc>(context).add(OnRenewTokenEvent());
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) =>
          (current is OnRenewTokenState && !current.isLoading),
      listener: (_, state) {
        if (state.valido) {
          Navigator.pushReplacementNamed(context, 'usuarios');
          BlocProvider.of<ServerStatusBloc>(context)
              .add(OnServerStatusChangeEvent(ServerStatus.Offline));
        } else {
          Navigator.pushReplacementNamed(context, 'login');
        }
      },
      child: Scaffold(
        body: Center(
          child: Text('Cargando..'),
        ),
      ),
    );
  }
}
