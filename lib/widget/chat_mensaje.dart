import 'package:flutter/material.dart';

import 'package:chat_app/helpers/helpers.dart';
import 'package:chat_app/models/chat_model.dart';

class ChatMensaje extends StatelessWidget {
  final ChatModel chat;
  final AnimationController animationController;

  const ChatMensaje({@required this.chat, @required this.animationController});
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Container(
          child: this.chat.uid == '123' ? _miMensaje() : _contactoMensaje(),
        ),
      ),
    );
  }

  Widget _miMensaje() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(bottom: 5, left: 50, right: 10),
        decoration: BoxDecoration(
            color: colorPrimarioUno, borderRadius: BorderRadius.circular(20)),
        child: Text(
          this.chat.mensaje,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _contactoMensaje() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(bottom: 5, left: 10, right: 50),
        decoration: BoxDecoration(
            color: Color(0xffE4E5E8), borderRadius: BorderRadius.circular(20)),
        child: Text(
          this.chat.mensaje,
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
