import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final SecureStorage _instancia = new SecureStorage.internal();

  final _storage = new FlutterSecureStorage();

  factory SecureStorage() {
    return _instancia;
  }

  FlutterSecureStorage get storage => this._storage;

  SecureStorage.internal();
}
