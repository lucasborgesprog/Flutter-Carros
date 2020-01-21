import 'dart:convert';

import 'package:carros_custom/utils/prefs.dart';

class Usuario {
  int id;
  String login;
  String nome;
  String email;
  String urlFoto;
  String token;
  List<String> roles;

  Usuario(
      {this.id,
      this.login,
      this.nome,
      this.email,
      this.urlFoto,
      this.token,
      this.roles});

  Usuario.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        login = json['login'],
        nome = json['nome'],
        email = json['email'],
        urlFoto = json['urlFoto'],
        token = json['token'],
        roles = json['roles'] != null ? json['roles'].cast<String>() : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login'] = this.login;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['urlFoto'] = this.urlFoto;
    data['token'] = this.token;
    data['roles'] = this.roles;
    return data;
  }

  @override
  String toString() {
    return 'Usuario{"id": $id,"login":$login,"nome":$nome,"email":$email,"urlFoto":$urlFoto,"roles":$roles}';
  }

  void save() {
    Map map = toJson();

    String jsonMap = json.encode(map);

    Prefs.setString("user.prefs", jsonMap);
  }

  static Future<Usuario> get() async {
    String jsonUser = await Prefs.getString("user.prefs");
    if (jsonUser.isEmpty) return null;

    Map map = json.decode(jsonUser);

    Usuario user = Usuario.fromJson(map);

    return user;
  }

  static clear() {
    Prefs.setString("user.prefs", "");
  }
}
