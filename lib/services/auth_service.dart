import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/login_response.dart';

class AuthService {
  Future<LoginResponse> login(String email, String password) async {
    final data = {'email': email, 'password': password};

    try {
      final url = Uri.parse('${Environment.apiUrl}login');

      final resp = await http.post(url,
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
      return loginResponseFromJson(resp.body);
    } catch (error) {
      return null;
    }
  }

  Future<LoginResponse> register(
      String nombre, String email, String password) async {
    final data = {'nombre': nombre, 'email': email, 'password': password};

    try {
      final url = Uri.parse('${Environment.apiUrl}login/new');

      final resp = await http.post(url,
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
      return loginResponseFromJson(resp.body);
    } catch (error) {
      return null;
    }
  }

  Future<LoginResponse> renovarJWT(String token) async {
    try {
      final url = Uri.parse('${Environment.apiUrl}login/renew');

      final resp = await http.get(url,
          headers: {'Content-Type': 'application/json', 'x-token': token});
      return loginResponseFromJson(resp.body);
    } catch (error) {
      return null;
    }
  }
}
