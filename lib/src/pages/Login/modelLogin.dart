import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:Pegaso/src/util/app-config.dart';

class TokenUsuarios {
  List<TokenUsuario> items = [];
  TokenUsuarios();
  TokenUsuarios.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarAsistenciaActual = new TokenUsuario.fromJson(item);
      items.add(_listarAsistenciaActual);
    }
  }
}

class TokenUsuario {
  bool estado;
  String token;

  TokenUsuario({this.estado: false, this.token = ''});

  TokenUsuario.fromMap(Map<String, dynamic> map) {
    estado = map['estado'];
    token = map['token'];
  }
  factory TokenUsuario.fromJson(Map<String, dynamic> parsedJson) {
    /// var list = json['response'] as List;

    // List<Response> objList = list.map((i) => Response.fromJson(i)).toList();
    return TokenUsuario(
      estado: parsedJson['estado'],
      token: parsedJson['token'],
    );
  }

  TokenUsuario.map(dynamic obj) {
    estado = obj["estado"];
    token = obj["token"];
  }

  bool get usernameU => estado;
  String get passwordP => token;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["estado"] = estado;
    map["token"] = token;

    return map;
  }
}

TokenUsuario tokenfue;
