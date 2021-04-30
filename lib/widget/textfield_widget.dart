import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:chat_app/widget/cambio_size_animation.dart';
import 'package:chat_app/widget/opacity_animation.dart';

import 'package:chat_app/helpers/helpers.dart' as estilo;

class TextfieldWidget extends StatelessWidget {
  final IconData icono;
  final bool iconoIzquida;
  final Color colorGradienteIconoInicio;
  final Color colorGradienteIconoFin;
  final String hindText;
  final double hintTextSize;
  final TextAlign alineacionTexto;
  final bool obscureText;
  final TextInputType textInputType;
  final TextEditingController controller;
  final bool enableInteractiveSelection;
  final Function onTap;
  final Function onChanged;
  final double alto;
  const TextfieldWidget(
      {this.icono = Icons.ac_unit,
      this.iconoIzquida = false,
      this.colorGradienteIconoInicio = Colors.grey,
      this.hindText = '',
      this.colorGradienteIconoFin = Colors.grey,
      this.alineacionTexto = TextAlign.center,
      this.obscureText = false,
      this.textInputType = TextInputType.text,
      this.controller,
      this.enableInteractiveSelection = true,
      this.onTap,
      this.onChanged,
      this.hintTextSize = 22,
      this.alto = 55});

  @override
  Widget build(BuildContext contextText) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Container(
        height: this.alto,
        decoration: BoxDecoration(
          color: this.colorGradienteIconoInicio,
          borderRadius: BorderRadius.circular(50),
          gradient: LinearGradient(colors: <Color>[
            this.colorGradienteIconoFin,
            this.colorGradienteIconoInicio.withOpacity(0.9),
          ], stops: [
            0.8,
            1.0
          ]),
        ),
        child: Row(
          children: <Widget>[
            if (this.iconoIzquida) _IconoTextfield(icono: this.icono),
            Expanded(
              child: _CampoTexto(
                hindText: this.hindText,
                alineacionTexto: this.alineacionTexto,
                obscureText: this.obscureText,
                textInputType: this.textInputType,
                controller: this.controller,
                enableInteractiveSelection: this.enableInteractiveSelection,
                onTap: this.onTap,
                onChanged: this.onChanged,
                hintTextSize: this.hintTextSize,
              ),
            ),
            if (!this.iconoIzquida) _IconoTextfield(icono: this.icono),
          ],
        ),
      ),
    );
  }
}

class _IconoTextfield extends StatelessWidget {
  const _IconoTextfield({
    @required this.icono,
  });

  final IconData icono;

  @override
  Widget build(BuildContext context) {
    return CambioSizeAnimation(
      sizeFinal: 40,
      sizeIniciar: 0,
      child: Container(
        width: 40,
        alignment: Alignment.center,
        child: OpacityAnimation(
          duration: Duration(milliseconds: 1300),
          child: FaIcon(
            this.icono,
            color: estilo.colorIconos,
          ),
        ),
      ),
    );
  }
}

class _CampoTexto extends StatelessWidget {
  const _CampoTexto({
    @required this.hindText,
    this.alineacionTexto,
    this.obscureText,
    this.textInputType,
    this.controller,
    this.enableInteractiveSelection,
    this.onTap,
    this.onChanged,
    this.hintTextSize,
  });

  final String hindText;
  final double hintTextSize;
  final TextAlign alineacionTexto;
  final bool obscureText;
  final TextInputType textInputType;
  final TextEditingController controller;
  final bool enableInteractiveSelection;
  final Function onTap;
  final Function onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 0, color: Colors.white),
        ),
        padding: EdgeInsets.all(0),
        child: TextField(
          textCapitalization: TextCapitalization.sentences,
          keyboardType: this.textInputType,
          obscureText: this.obscureText,
          textAlign: this.alineacionTexto,
          controller: this.controller,
          style: TextStyle(
            fontSize: 22,
          ),
          decoration: new InputDecoration(
            hintText: this.hindText,
            hintStyle: TextStyle(
                fontSize: this.hintTextSize,
                fontWeight: FontWeight.bold,
                color: Colors.grey),
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(
                left: this.alineacionTexto == TextAlign.start ? 15 : 0),
          ),
          onTap: this.onTap,
          onChanged: this.onChanged,
        ));
  }
}
