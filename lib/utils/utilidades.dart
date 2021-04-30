import 'dart:io';

class Utilidades {
  /// Determina si existeAchivo [fullpath]
  /// devuelve true/false segun el caso

  Utilidades();

  Future<bool> existeAchivo(String fullpath) async {
    if (fullpath == null || fullpath == 'NOK') {
      return false;
    }
    final file = File(fullpath);
    if (file.existsSync()) {
      return true;
    } else {
      return false;
    }
  }
}
