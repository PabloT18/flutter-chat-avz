import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/models/login-response.dart';
import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/models/usuario.dart';

class AuthService with ChangeNotifier {
  Usuario usuario;
  bool _autenticando = false;

  //crear instanci del storaga
  final _storage = new FlutterSecureStorage();

  Future<bool> login(String email, String password) async {
    this.autenticando = true;

    //data que se envia al bakend
    final data = {'email': email, 'password': password};

    final resp = await http.post(
      '${Enviroments.apiURL}/login',
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    print(resp.body);
    this.autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      await _guardarToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future register(String nombre, String email, String password) async {
    this.autenticando = true;

    final data = {'nombre': nombre, 'email': email, 'password': password};

    final resp = await http.post(
      '${Enviroments.apiURL}/login/new',
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    this.autenticando = false;
    print(resp.body);
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      await _guardarToken(loginResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future _logOut() async {
    return await _storage.delete(key: 'token');
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');

    final resp = await http.get(
      '${Enviroments.apiURL}/login/renew',
      headers: {'Content-Type': 'application/json', 'x-token': token},
    );

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      await _guardarToken(loginResponse.token);
      return true;
    } else {
      this._logOut();
      return false;
    }
  }

  ////Getters & Setters
  // bool autenticando
  bool get autenticando => this._autenticando;
  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  //token estaticos
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = _storage.read(key: 'token');
    return token;
  }

  static Future<void> delToken() async {
    final _storage = new FlutterSecureStorage();
    _storage.delete(key: 'token');
  }
}
