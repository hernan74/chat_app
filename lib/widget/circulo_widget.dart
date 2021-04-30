import 'package:flutter/material.dart';

class CirculoWidget extends StatelessWidget {
  final double sizeCirculo;
  final Color colorCiculo;
  final Widget contenidoCirculo;
  final int elevacionCirculo;
  final bool utilizaShadow;
  const CirculoWidget(
      {this.sizeCirculo = 50,
      this.colorCiculo = Colors.grey,
      this.contenidoCirculo,
      this.elevacionCirculo = 0,
      this.utilizaShadow = true});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.sizeCirculo,
      height: this.sizeCirculo,
      decoration: BoxDecoration(
          color: this.colorCiculo,
          borderRadius: BorderRadius.circular(200),
          boxShadow: <BoxShadow>[
            if (utilizaShadow)
              BoxShadow(
                  color: colorCiculo.withOpacity(0.5),
                  spreadRadius: 10,
                  blurRadius: 20)
          ]),
      child: this.contenidoCirculo,
    );
  }
}
