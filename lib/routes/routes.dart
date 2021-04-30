import 'package:get/get.dart';

import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/loading_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/pages/usuarios_page.dart';

final List<GetPage<dynamic>> appRoutes = [
  GetPage(name: 'usuarios', page: () => UsuariosPage()),
  GetPage(name: 'chat', page: () => ChatPage()),
  GetPage(name: 'login', page: () => LoginPage()),
  GetPage(name: 'register', page: () => RegisterPage()),
  GetPage(name: 'loading', page: () => LoadingPage()),
];
