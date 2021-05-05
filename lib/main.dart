import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app/chat/chat_bloc.dart';
import 'bloc/usuario/usuario_bloc.dart';

import 'package:chat_app/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UsuarioBloc>(create: (_) => UsuarioBloc()),
        BlocProvider<ChatBloc>(create: (_) => ChatBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: ' Titulo',
        initialRoute: 'chat',
        routes: appRoutes,
      ),
    );
  }
}
