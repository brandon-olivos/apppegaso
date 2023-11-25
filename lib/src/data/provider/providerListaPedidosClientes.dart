import 'dart:convert';
import 'dart:io';

import 'package:Pegaso/src/Pages/Login/modelLogin.dart';
import 'package:Pegaso/src/data/db/token.dart';
import 'package:Pegaso/src/data/models/ListaPedidosClientes.dart';
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

class ProviderListaPedidosClientes {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  Future<List<ListaPedidosClientes>> getListaPedidosClientes(valor) async {
    await TraerToken().mostrarDatos();

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/pedidoscliente/rest/lista'),
        headers: TraerToken.headers,
        body: '{"buscar" : "$valor"}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadostraba =
          new ListaPedidosClientes2.fromJsonList(jsonResponse["data"]);

      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  //
  //
//
  Future<ListaPedidosClientes> getpedidocliente(valob) async {
    await TraerToken().mostrarDatos();
    ListaPedidosClientes as = new ListaPedidosClientes();
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil +
            '/pedidoscliente/rest/getpedidocliente'),
        body: '{"id_pedido_cliente": "$valob"}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final listadostraba = listaPedidosClientesFromJson(response.body);

      return listadostraba[0];
    } else if (response.statusCode == 400) {}
    return as;
  }

  Future<int> eliminarPedidosCliente({id_pedido_cliente}) async {
    await TraerToken().mostrarDatos();
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/pedidoscliente/rest/delete'),
        body: '{'
            '"id_pedido_cliente": "$id_pedido_cliente"'
            '}',
        headers: TraerToken.headers);

    print('{'
        '"id_pedido_cliente": $id_pedido_cliente'
        '}');

    print(TraerToken.headers);
    print(response.body);
    if (response.statusCode == 200) {
      await DatabasePr.db.eliminarTodo();
      return response.statusCode;
    } else if (response.statusCode == 400) {
      return response.statusCode;
    }
  }

  ///
  /////
  ///
  ///
  Future<int> editarPedidosCliente(
      {fecha = '',
      hora_recojo = '',
      id_pedido_cliente,
      tipo_servicio,
      id_tipo_unidad,
      id_direccion_recojo}) async {
    await TraerToken().mostrarDatos();

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/pedidoscliente/rest/update'),
        body: '{'
            '"id_pedido_cliente": "$id_pedido_cliente",'
            '"tipo_servicio": "$tipo_servicio",'
            '"id_direccion_recojo": "$id_direccion_recojo",'
            '"id_tipo_unidad": "$id_tipo_unidad",'
            '"hora_recojo": "$hora_recojo",'
            '"fecha": "$fecha"'
            '}',
        headers: TraerToken.headers);

    print('{'
        '"id_pedido_cliente": $id_pedido_cliente,'
        '"tipo_servicio": $tipo_servicio,'
        '"id_direccion_recojo": $id_direccion_recojo,'
        '"id_tipo_unidad": $id_tipo_unidad,'
        '"hora_recojo": "$hora_recojo",'
        '"fecha": "$fecha"'
        '}');

    print(TraerToken.headers);
    print(response.body);
    if (response.statusCode == 200) {
      await DatabasePr.db.eliminarTodo();
      return response.statusCode;
    } else if (response.statusCode == 400) {
      return response.statusCode;
    }
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
      {ListaPedidosClientes pedidoclientesave}) async {
    await TraerToken().mostrarDatos();

    var a = await DatabasePr.db.getDtaGRCjs();

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/pedidoscliente/rest/create'),
        body: '{'
            '"fecha":"${pedidoclientesave.fecha}",'
            '"hora_recojo":"${pedidoclientesave.hora_recojo}",'
            '"id_direccion_recojo":"${pedidoclientesave.id_direccion_recojo}",'
            '"tipo_servicio":"${pedidoclientesave.tipo_servicio}",'
            '"id_tipo_unidad":"${pedidoclientesave.id_tipo_unidad}"'
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
