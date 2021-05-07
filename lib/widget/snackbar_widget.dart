import 'package:flutter/material.dart';

void mostrarSnackBar(
    {@required BuildContext context,
    @required String msj,
    bool isError = false}) {
  final snak = SnackBar(
    content: Text(
      msj,
      style: TextStyle(color: Colors.white, fontSize: 18.0),
    ),
    duration: Duration(milliseconds: 1500),
    backgroundColor: isError ? Colors.redAccent : Colors.blueAccent,
  );
  ScaffoldMessenger.of(context).showSnackBar(snak);
}
