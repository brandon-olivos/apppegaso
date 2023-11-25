import 'dart:convert';
import 'dart:io';

import 'package:Pegaso/src/Pages/Login/modelLogin.dart';
import 'package:Pegaso/src/data/db/token.dart';
import 'package:Pegaso/src/data/models/ListaSeguimientoNuevo.dart';
import 'package:Pegaso/src/data/models/TipoUnidad.dart';
import 'package:Pegaso/src/data/models/TipoViaCarga.dart';
import 'package:Pegaso/src/data/models/direccion.dart';
import 'package:Pegaso/src/data/models/estados.dart';
import 'package:Pegaso/src/data/models/tipoServicio.dart';
import 'package:Pegaso/src/data/provider/TraerToken.dart';
import 'package:Pegaso/src/util/app-config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

// Trabajador trabajador;
var dato;

class ProviderSeguimientoClientes {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  Future<List<ListaSeguimientoNuevos>> getListaSeguimientoClientes(
      valor) async {
    await TraerToken().mostrarDatos();

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/seguimientocliente/rest/lista'),
        headers: TraerToken.headers,
        body: '{"buscar" : "$valor"}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadostraba =
          new ListaSeguimientoNuevos2.fromJsonList(jsonResponse["data"]);

      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  //
  //
//
  Future<ListaSeguimientoNuevos> getseguimientocliente(valob) async {
    await TraerToken().mostrarDatos();
    ListaSeguimientoNuevos as = new ListaSeguimientoNuevos();
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil +
            '/seguimientocliente/rest/getseguimientocliente'),
        body: '{"id_guia_remision": "$valob"}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final listadostraba = listaSeguimientoNuevosFromJson(response.body);

      return listadostraba[0];
    } else if (response.statusCode == 400) {}
    return as;
  }

  ////
  /////
  ///
  ///
  ///
  static Future<List<TipoServicio>> getServicio(String query) async {
    await TraerToken().mostrarDatos();
    final url = Uri.parse(
      AppConfig.urlBackendMovil + '/pedidoscliente/rest/tipo-servicio',
    );
    final response = await http.get(url, headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final List users = json.decode(response.body);

      return users.map((json) => TipoServicio.fromJson(json)).where((user) {
        final nameLower = user.nombre_producto.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  static Future<List<DireccionesMod>> getDireccionRecojo(String query) async {
    await TraerToken().mostrarDatos();
    final url = Uri.parse(
      AppConfig.urlBackendMovil + '/pedidoscliente/rest/direccion',
    );
    final response = await http.get(url, headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final List users = json.decode(response.body);

      return users.map((json) => DireccionesMod.fromJson(json)).where((user) {
        final nameLower = user.direccion.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  static Future<List<TipoUnidad>> getTipoUnidad(String query) async {
    await TraerToken().mostrarDatos();
    final url = Uri.parse(
      AppConfig.urlBackendMovil + '/pedidoscliente/rest/tipo-unidad',
    );
    final response = await http.get(url, headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final List users = json.decode(response.body);

      return users.map((json) => TipoUnidad.fromJson(json)).where((user) {
        final nameLower = user.descripcion.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<String> GuardarPedidoCliente(
      {ListaSeguimientoNuevos pedidoclientesave}) async {
    await TraerToken().mostrarDatos();

    var a = await DatabasePr.db.getDtaGRCjs();

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/pedidoscliente/rest/create'),
        body: '{'
            '"fecha":"${pedidoclientesave.numero_guia}",'
            '"hora_recojo":"${pedidoclientesave.numero_guia}",'
            '"id_direccion_recojo":"${pedidoclientesave.numero_guia}",'
            '"tipo_servicio":"${pedidoclientesave.numero_guia}",'
            '"id_tipo_unidad":"${pedidoclientesave.numero_guia}"'
            '}',
        headers: TraerToken.headers);

    print(response.body);
    if (response.statusCode == 200) {
      return response.statusCode.toString();
    } else if (response.statusCode == 400) {
      return response.statusCode.toString();
    }
    return response.statusCode.toString();
  }
}
