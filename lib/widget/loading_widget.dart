import 'package:flutter/material.dart';

import 'package:chat_app/utils/size_scream_util.dart';
import 'package:chat_app/widget/opacity_animation.dart';

class LoadingWidget extends StatelessWidget {
  final bool estado;
  final Widget child;
  final double altoWidget;
  final double anchoWidget;

  LoadingWidget(
      {@required this.estado,
      @required this.child,
      this.altoWidget = 130,
      this.anchoWidget = 130});
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return estado
            ? child
            : OpacityAnimation(
                duration: Duration(milliseconds: 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: EdgeInsets.all(sizeScreemUtil(
                            sizeActual: altoWidget * 18.3 / 100,
                            sizeMin: 0,
                            sizeMax: 20)),
                        width: this.altoWidget,
                        height: this.altoWidget,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.black54.withOpacity(0.4)),
                        child: CircularProgressIndicator()),
                    Text(
                      'Cargando',
                      style: TextStyle(
                          fontSize: sizeScreemUtil(
                              sizeActual: altoWidget * 16.5 / 100,
                              sizeMin: 10,
                              sizeMax: 18),
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
