import 'package:flutter/material.dart';

import 'package:chat_app/utils/size_scream_util.dart';
import 'package:chat_app/widget/button_widget.dart';
import 'package:chat_app/widget/fondo_login_widget.dart';
import 'package:chat_app/widget/opacity_animation.dart';
import 'package:chat_app/widget/textfield_widget.dart';

import 'package:chat_app/helpers/helpers.dart' as estilo;

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double anchoMaximo = sizeScreemUtil(
        sizeActual: size.width * 90 / 100, sizeMin: 400, sizeMax: 650);
    double altoMaximo = sizeScreemUtil(
        sizeActual: size.height * 60 / 100, sizeMin: 252, sizeMax: 400);

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.center,
          children: [
            FondoLoginWidget(),
            Container(
              height: 600,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Container(
                  height: 550,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      _Titulo(
                        anchoMaximo: anchoMaximo,
                        altoMaximo: altoMaximo,
                      ),
                      _FormularioLogin(
                        altoMaximo: altoMaximo,
                        anchoMaximo: anchoMaximo,
                      ),
                      Container(
                        width: 200,
                        height: 100,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              '¿No tienes cuenta?',
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 20),
                            ),
                            MaterialButton(
                                child: Text(
                                  'Crea una ahora!',
                                  style: TextStyle(
                                      color: estilo.colorPrimarioDos,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () =>
                                    Navigator.pushNamed(context, 'register'))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class _Titulo extends StatelessWidget {
  final double anchoMaximo;
  final double altoMaximo;

  const _Titulo({@required this.anchoMaximo, @required this.altoMaximo});
  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      duration: Duration(seconds: 1),
      child: Container(
        width: anchoMaximo * 95 / 100,
        alignment: Alignment.centerRight,
        margin: EdgeInsets.only(bottom: 20.0),
        child: Text(
          'Ingresar',
          style: TextStyle(
              fontSize: sizeScreemUtil(
                  sizeActual: altoMaximo * 10 / 100, sizeMin: 20, sizeMax: 40),
              color: estilo.colorTituloLogin),
        ),
      ),
    );
  }
}

class _FormularioLogin extends StatelessWidget {
  final double altoMaximo;
  final double anchoMaximo;

  const _FormularioLogin({this.altoMaximo, this.anchoMaximo});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          TextfieldWidget(
            alto: sizeScreemUtil(
                sizeActual: this.altoMaximo * 15 / 100,
                sizeMin: 10,
                sizeMax: 55),
            icono: Icons.markunread_sharp,
            colorGradienteIconoInicio: estilo.colorPrimarioUno,
            colorGradienteIconoFin: estilo.colorPrimarioUnoGradiente,
            hintTextSize: sizeScreemUtil(
                sizeActual: this.altoMaximo * 5.5 / 100,
                sizeMin: 10,
                sizeMax: 22),
            hindText: 'Email',
            onChanged: (value) {
              //TODO tomar datos
            },
          ),
          SizedBox(
            height: sizeScreemUtil(
                sizeActual: this.altoMaximo * 4.5 / 100,
                sizeMin: 10,
                sizeMax: 20),
          ),
          TextfieldWidget(
            alto: sizeScreemUtil(
                sizeActual: this.altoMaximo * 15 / 100,
                sizeMin: 10,
                sizeMax: 55),
            iconoIzquida: true,
            icono: Icons.vpn_key_sharp,
            colorGradienteIconoInicio: estilo.colorPrimarioDos,
            colorGradienteIconoFin: estilo.colorPrimarioDosGradiente,
            hindText: 'Contraseña',
            hintTextSize: sizeScreemUtil(
                sizeActual: this.altoMaximo * 5.5 / 100,
                sizeMin: 10,
                sizeMax: 22),
            obscureText: true,
            onChanged: (value) {
              //TODO tomar datos
            },
          ),
          SizedBox(
              height: sizeScreemUtil(
                  sizeActual: this.altoMaximo * 5 / 100,
                  sizeMin: 0,
                  sizeMax: 20)),
          Text(
            ' state.error',
            style: TextStyle(
                fontSize: sizeScreemUtil(
                    sizeActual: this.altoMaximo * 4.8 / 100,
                    sizeMin: 10,
                    sizeMax: 22),
                color: estilo.colorError,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
              height: sizeScreemUtil(
                  sizeActual: this.altoMaximo * 10 / 100,
                  sizeMin: 0,
                  sizeMax: 60)),
          ButtonWidget(
              widget: Text('Login',
                  style: TextStyle(
                      color: estilo.colorTextoBoton,
                      fontWeight: FontWeight.bold,
                      fontSize: sizeScreemUtil(
                          sizeActual: this.altoMaximo * 5.5 / 100,
                          sizeMin: 10,
                          sizeMax: 22))),
              ancho: this.anchoMaximo * 80 / 100,
              alto: this.altoMaximo * 15 / 100,
              utilizaGradiente: true,
              //TODO Validar datos
              colorGradienteInicio:
                  (true) ? estilo.colorPrimarioDos : Colors.grey,
              colorGradienteFinal:
                  (true) ? estilo.colorPrimarioUno : Colors.grey,
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, 'usuarios')),
        ],
      ),
    );
  }
}
