import 'package:flutter/material.dart';

import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/widget/circulo_widget.dart';

class ItemListaUsuariosWidget extends StatelessWidget {
  final Usuario usuario;
  final Function onTap;

  const ItemListaUsuariosWidget({
    @required this.usuario,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.orange.withOpacity(0.7),
          child: Text(this.usuario.nombre.substring(0, 2)),
        ),
        title: Text(this.usuario.nombre),
        subtitle: Text(this.usuario.email),
        trailing: CirculoWidget(
          colorCiculo:
              this.usuario.online ? Colors.greenAccent : Colors.redAccent,
          sizeCirculo: 10,
          utilizaShadow: false,
        ),
      ),
    );
  }
}
