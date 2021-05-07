import 'package:chat_app/bloc/login/login_bloc.dart';
import 'package:chat_app/widget/snackbar_widget.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/utils/size_scream_util.dart';
import 'package:chat_app/widget/button_widget.dart';
import 'package:chat_app/widget/fondo_login_widget.dart';
import 'package:chat_app/widget/opacity_animation.dart';
import 'package:chat_app/widget/textfield_widget.dart';

import 'package:chat_app/helpers/helpers.dart' as estilo;
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double anchoMaximo = sizeScreemUtil(
        sizeActual: size.width * 90 / 100, sizeMin: 400, sizeMax: 650);
    double altoMaximo = sizeScreemUtil(
        sizeActual: size.height * 60 / 100, sizeMin: 252, sizeMax: 400);

    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) =>
          (current is OnRegisterState) && !current.isLoading,
      listener: (_, state) {
        print('Se dispara el listener de registrar');
        if (state.valido) {
          Navigator.pushReplacementNamed(context, 'login');
          return;
        }
        mostrarSnackBar(context: context, msj: state.msError, isError: true);
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            alignment: Alignment.center,
            children: [
              FondoLoginWidget(),
              Positioned(
                top: 30,
                left: 5,
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: () => Navigator.pop(context)),
              ),
              Container(
                height: 600,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
                  child: Container(
                    height: 650,
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
                                '¿Tienes Cuenta?',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 20),
                              ),
                              MaterialButton(
                                  child: Text(
                                    'Inicia Sesion!',
                                    style: TextStyle(
                                        color: estilo.colorPrimarioDos,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () =>
                                      Navigator.pushReplacementNamed(
                                          context, 'login'))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
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
          'Nuevo Usuario',
          style: TextStyle(
              fontSize: sizeScreemUtil(
                  sizeActual: altoMaximo * 10 / 100, sizeMin: 20, sizeMax: 40),
              color: estilo.colorTituloLogin),
        ),
      ),
    );
  }
}

class _FormularioLogin extends StatefulWidget {
  final double altoMaximo;
  final double anchoMaximo;

  const _FormularioLogin({this.altoMaximo, this.anchoMaximo});

  @override
  __FormularioLoginState createState() => __FormularioLoginState();
}

class __FormularioLoginState extends State<_FormularioLogin> {
  final TextEditingController _nombreController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          TextfieldWidget(
            controller: _nombreController,
            alto: sizeScreemUtil(
                sizeActual: this.widget.altoMaximo * 15 / 100,
                sizeMin: 10,
                sizeMax: 55),
            icono: Icons.markunread_sharp,
            colorGradienteIconoInicio: estilo.colorPrimarioUno,
            colorGradienteIconoFin: estilo.colorPrimarioUnoGradiente,
            hintTextSize: sizeScreemUtil(
                sizeActual: this.widget.altoMaximo * 5.5 / 100,
                sizeMin: 10,
                sizeMax: 22),
            hindText: 'Nombre',
          ),
          SizedBox(
            height: sizeScreemUtil(
                sizeActual: this.widget.altoMaximo * 4.5 / 100,
                sizeMin: 10,
                sizeMax: 20),
          ),
          TextfieldWidget(
            controller: _emailController,
            alto: sizeScreemUtil(
                sizeActual: this.widget.altoMaximo * 15 / 100,
                sizeMin: 10,
                sizeMax: 55),
            iconoIzquida: true,
            icono: Icons.vpn_key_sharp,
            colorGradienteIconoInicio: estilo.colorPrimarioDos,
            colorGradienteIconoFin: estilo.colorPrimarioDosGradiente,
            hindText: 'Correo',
            hintTextSize: sizeScreemUtil(
                sizeActual: this.widget.altoMaximo * 5.5 / 100,
                sizeMin: 10,
                sizeMax: 22),
          ),
          SizedBox(
            height: sizeScreemUtil(
                sizeActual: this.widget.altoMaximo * 4.5 / 100,
                sizeMin: 10,
                sizeMax: 20),
          ),
          TextfieldWidget(
            controller: _passwordController,
            alto: sizeScreemUtil(
                sizeActual: this.widget.altoMaximo * 15 / 100,
                sizeMin: 10,
                sizeMax: 55),
            icono: Icons.vpn_key_sharp,
            colorGradienteIconoInicio: estilo.colorPrimarioUno,
            colorGradienteIconoFin: estilo.colorPrimarioUnoGradiente,
            hindText: 'Clave',
            hintTextSize: sizeScreemUtil(
                sizeActual: this.widget.altoMaximo * 5.5 / 100,
                sizeMin: 10,
                sizeMax: 22),
            obscureText: true,
          ),
          SizedBox(
              height: sizeScreemUtil(
                  sizeActual: this.widget.altoMaximo * 10 / 100,
                  sizeMin: 0,
                  sizeMax: 60)),
          BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (previous, current) => (current is OnRegisterState),
            builder: (_, state) {
              return ButtonWidget(
                widget: Text('Crer Cuenta',
                    style: TextStyle(
                        color: estilo.colorTextoBoton,
                        fontWeight: FontWeight.bold,
                        fontSize: sizeScreemUtil(
                            sizeActual: this.widget.altoMaximo * 5.5 / 100,
                            sizeMin: 10,
                            sizeMax: 22))),
                ancho: this.widget.anchoMaximo * 80 / 100,
                alto: this.widget.altoMaximo * 15 / 100,
                utilizaGradiente: true,
                colorGradienteInicio: (!state.isLoading)
                    ? estilo.colorPrimarioDos
                    : Colors.blueGrey,
                colorGradienteFinal: (!state.isLoading)
                    ? estilo.colorPrimarioUno
                    : Colors.blueGrey,
                onPressed: (!state.isLoading)
                    ? () {
                        BlocProvider.of<LoginBloc>(context).add(OnRegisterEvent(
                            _nombreController.text,
                            _emailController.text,
                            _passwordController.text));
                      }
                    : null,
              );
            },
          ),
        ],
      ),
    );
  }
}
