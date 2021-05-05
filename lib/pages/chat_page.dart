import 'package:flutter/material.dart';

import 'package:chat_app/chat/chat_bloc.dart';

import 'package:chat_app/widget/chat_mensaje.dart';
import 'package:chat_app/helpers/helpers.dart' as estilo;
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  List<AnimationController> _animationsControllers = <AnimationController>[];

  @override
  void dispose() {
    for (AnimationController controller in _animationsControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        toolbarHeight: 60,
        title: Column(
          children: <Widget>[
            CircleAvatar(
              child: Text(
                'Te',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
              backgroundColor: estilo.colorPrimarioUno,
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'Hernan Lopez',
              style: TextStyle(
                  fontSize: 15,
                  color: estilo.colorPrimarioDos,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(child: BlocBuilder<ChatBloc, ChatState>(
              builder: (_, state) {
                return ListView(
                  physics: BouncingScrollPhysics(),
                  children: (state.chat == null)
                      ? []
                      : state.chat.map((e) {
                          final _animationController = AnimationController(
                              vsync: this,
                              duration: Duration(milliseconds: 400));
                          this._animationsControllers.add(_animationController);
                          final nuevoMensaje = new ChatMensaje(
                            chat: e,
                            animationController: _animationController,
                          );
                          if (e.nuevo) {
                            nuevoMensaje.animationController.forward();
                          } else {
                            nuevoMensaje.animationController.forward(from: 1.0);
                          }
                          return nuevoMensaje;
                        }).toList(),
                  reverse: true,
                );
              },
            )),
            Divider(
              height: 1,
            ),
            _EnviarMensaje()
          ],
        ),
      ),
    );
  }
}

class _EnviarMensaje extends StatefulWidget {
  const _EnviarMensaje({
    Key key,
  }) : super(key: key);

  @override
  __EnviarMensajeState createState() => __EnviarMensajeState();
}

class __EnviarMensajeState extends State<_EnviarMensaje> {
  final FocusNode _focusNode = new FocusNode();
  final TextEditingController textController =
      new TextEditingController(text: '');

  bool escribiendo = false;
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white),
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: textController,
                onSubmitted: _handleSubmit,
                onChanged: (value) {
                  setState(() {
                    if (value.trim().length > 0) {
                      this.escribiendo = true;
                    } else {
                      this.escribiendo = false;
                    }
                  });
                },
                decoration:
                    InputDecoration.collapsed(hintText: 'Enviar mensaje'),
                focusNode: _focusNode,
              ),
            ),
            IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                color: estilo.colorPrimarioDos,
                icon: Icon(Icons.send),
                onPressed: this.escribiendo
                    ? () => _handleSubmit(this.textController.text)
                    : null)
          ],
        ),
      ),
    );
  }

  _handleSubmit(String submit) {
    if (submit.length == 0) return;
    print(submit);
    setState(() {
      this.escribiendo = false;
    });
    final String mensaje = submit;
    BlocProvider.of<ChatBloc>(context).add(OnEnviarMensaje(mensaje));
    textController.clear();
    _focusNode.requestFocus();
  }
}
