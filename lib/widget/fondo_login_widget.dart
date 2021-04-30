import 'package:flutter/material.dart';

import 'package:chat_app/helpers/helpers.dart' as estilo;

class FondoLoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: CustomPaint(
        painter: _HeaderPaiter(),
      ),
    );
  }
}

class _HeaderPaiter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _crearfiguraColorSuperor(canvas, size);
    _crearfiguraColorInferior(canvas, size);
    _crearFiguraBlancaConSombraSuperior(canvas, size);
    _crearFiguraBlancaConSombraInferior(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void _crearfiguraColorSuperor(Canvas canvas, Size size) {
    final Rect rect =
        new Rect.fromCircle(center: Offset(0.0, 150.0), radius: 180);
    //Gradiente rosado
    final Gradient gradiente = new LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          estilo.colorPrimarioDos.withOpacity(0.9),
          estilo.colorPrimarioDosGradiente,
          estilo.colorPrimarioUno,
          estilo.colorPrimarioUnoGradiente
        ],
        stops: [
          0.2,
          0.5,
          0.8,
          0.9
        ]);
    final paint = new Paint()..shader = gradiente.createShader(rect);

    //Propiedades
    paint.style = PaintingStyle.fill; //stroke  fill
    paint.strokeWidth = 5;

    final path = new Path();

    //Dibujo
    //
    path.moveTo(0, size.height * 0.4);
    path.lineTo(size.width * 0.17, size.height * 0.52);
    path.quadraticBezierTo(
        size.width * 0.2, size.height * 0.3, size.width, size.height * 0.2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  void _crearfiguraColorInferior(Canvas canvas, Size size) {
    final Rect rect =
        new Rect.fromCircle(center: Offset(0.0, 150.0), radius: 180);
    //Gradiente rosado
    final Gradient gradiente = new LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [estilo.colorPrimarioUno, estilo.colorPrimarioUnoGradiente]);
    final paint = new Paint()..shader = gradiente.createShader(rect);

    //Propiedades
    paint.style = PaintingStyle.fill; //stroke  fill
    paint.strokeWidth = 5;

    final path = new Path();

    path.moveTo(size.width * 0.7, size.height);
    path.quadraticBezierTo(size.width * 0.92, size.height * 0.85,
        size.width * 0.8, size.height * 0.72);
    path.lineTo(size.width, size.height * 0.81);
    path.lineTo(size.width, size.height);

    canvas.drawPath(path, paint);
  }

  void _crearFiguraBlancaConSombraSuperior(Canvas canvas, Size size) {
    final paint = new Paint();

    //Propiedades
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill; //stroke  fill
    paint.strokeWidth = 5;

    final path = new Path();

    path.moveTo(size.width * 0.17, size.height * 0.52);
    path.quadraticBezierTo(
        size.width * 0.2, size.height * 0.3, size.width, size.height * 0.2);
    path.lineTo(size.width, size.height * 0.24);
    path.lineTo(size.width * 0.17, size.height * 0.54);
    canvas.drawShadow(
        path.shift(Offset(0, -30)), Colors.black.withOpacity(0.6), 15.0, true);

    canvas.drawPath(path, paint);
  }

  void _crearFiguraBlancaConSombraInferior(Canvas canvas, Size size) {
    final paint = new Paint();

    //Propiedades
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill; //stroke  fill
    paint.strokeWidth = 5;

    final path = new Path();

    path.moveTo(size.width * 0.7, size.height);
    path.quadraticBezierTo(size.width * 0.92, size.height * 0.85,
        size.width * 0.8, size.height * 0.72);
    path.lineTo(size.width * 0.78, size.height * 0.72);
    path.lineTo(size.width * 0.6, size.height);
    canvas.drawShadow(
        path.shift(Offset(20, 0)), Colors.black.withOpacity(0.6), 15.0, true);

    canvas.drawPath(path, paint);
  }
}
