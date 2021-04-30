import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Widget widget;
  final Color colorGradienteInicio;
  final Color colorGradienteFinal;
  final double ancho;
  final double alto;
  final double bordeRedondeado;
  final Function onPressed;
  final bool utilizaGradiente;

  const ButtonWidget(
      {@required this.widget,
      this.colorGradienteInicio = Colors.grey,
      this.ancho = 70,
      this.alto = 70,
      this.bordeRedondeado = 50,
      this.onPressed,
      this.utilizaGradiente = false,
      this.colorGradienteFinal = Colors.grey});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: this.onPressed,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(this.bordeRedondeado),
          ),
          child: Container(
            width: this.ancho,
            height: this.alto,
            decoration: BoxDecoration(
              color: this.colorGradienteInicio,
              borderRadius: BorderRadius.circular(this.bordeRedondeado),
              gradient: LinearGradient(
                colors: this.utilizaGradiente
                    ? <Color>[
                        this.colorGradienteInicio,
                        this.colorGradienteFinal,
                      ]
                    : [this.colorGradienteInicio, this.colorGradienteInicio],
              ),
            ),
            child: this.widget,
            alignment: Alignment.center,
          ),
        ),
        style: ButtonStyle(
            minimumSize:
                MaterialStateProperty.all<Size>(Size(this.ancho, this.alto)),
            elevation: MaterialStateProperty.all<double>(0),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(this.bordeRedondeado)))));
  }
}
