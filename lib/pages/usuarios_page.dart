import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/widget/item_lista_usuarios_widget.dart';
import 'package:chat_app/helpers/helpers.dart' as estilo;

class UsuariosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);

    final List<Usuario> usuarios = [
      Usuario(
          online: false, email: 'test1@test.com', nombre: 'Hernan', uid: '1'),
      Usuario(online: true, email: 'test2@test.com', nombre: 'Juan', uid: '2'),
      Usuario(
          online: false, email: 'test3@test.com', nombre: 'Pedro', uid: '3'),
      Usuario(
          online: false, email: 'test4@test.com', nombre: 'Nahuel', uid: '4'),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi nombre'),
        centerTitle: true,
        backgroundColor: estilo.colorPrimarioUno.withOpacity(0.9),
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.cloud,
              color: Colors.blue,
            ),
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
          ),
        ],
      ),
      body: Container(
        child: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          header: WaterDropHeader(
            complete: Icon(
              Icons.check,
              color: Colors.blue,
            ),
            waterDropColor: Colors.blue,
          ),
          onRefresh: _cargarUsuario,
          child: _ListaUsuarios(usuarios: usuarios),
        ),
      ),
    );
  }

  _cargarUsuario() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    // _refreshController.refreshCompleted();
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
        );
      },
    );
  }
}
