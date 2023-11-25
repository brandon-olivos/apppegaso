import 'dart:convert';

import 'package:Pegaso/src/data/db/token.dart';

import 'package:Pegaso/src/data/models/TipoCarga.dart';
import 'package:Pegaso/src/data/models/TipoViaCarga.dart';
import 'package:Pegaso/src/data/models/agente.dart';

import 'package:Pegaso/src/data/models/entidades.dart';

import 'package:Pegaso/src/data/models/listaAsignacion.dart';
import 'package:Pegaso/src/data/models/Via.dart';
import 'package:Pegaso/src/data/models/listaDetallePedido.dart';
import 'package:Pegaso/src/data/provider/TraerToken.dart';
import 'package:Pegaso/src/data/provider/provider.dart';
import 'package:Pegaso/src/util/app-config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var dato;

class ProviderAsignacion {
  Future<List<ListaAsignacion>> getListaAsignaciones(valob) async {
    await TraerToken().mostrarDatos();

    http.Response response = await http.post(
        Uri.parse(
            AppConfig.urlBackendMovil + '/atenderasignaciones/rest/lista'),
        body: '{"buscar": "$valob"}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadostraba =
          new ListaAsignaciones.fromJsonList(jsonResponse["data"]);

      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  static Future<List<Agente>> getUserSuggestions(String query) async {
    await TraerToken().mostrarDatos();

    final url = Uri.parse(
      AppConfig.urlBackendMovil + '/atenderasignaciones/rest/agente',
    );
    final response = await http.get(url, headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final List users = json.decode(response.body);

      return users.map((json) => Agente.fromJson(json)).where((user) {
        final nameLower = user.cuenta.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  static Future<List<Entidad>> getEndidadSuggestions(String query) async {
    await TraerToken().mostrarDatos();
    final url = Uri.parse(
      AppConfig.urlBackendMovil + '/atenderasignaciones/rest/entidades',
    );
    final response = await http.get(url, headers: TraerToken.headers);
    if (response.statusCode == 200) {
      final List users = json.decode(response.body);

      return users.map((json) => Entidad.fromJson(json)).where((user) {
        final nameLower = user.razon_social.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<int> registrarGuia(
      {fecha,
      traslado,
      via,
      cliente,
      agente,
      remitente,
      direccion_partida,
      destinatario = '',
      direccion_llegada,
      conductor,
      vehiculo,
      nm_solicitud,
      via_tipo = '',
      id_atencion_pedido,
      imagen}) async {
    await TraerToken().mostrarDatos();

    var a = await DatabasePr.db.getDtaGRCjs();

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/atenderasignaciones/rest/suma'),
        body: '{'
            '"id_atencion_pedido":"$id_atencion_pedido",'
            '"fecha" : "$fecha",'
            '"traslado" : "$traslado",'
            '"via" : "$via",'
            '"cliente" : "$cliente",'
            '"agente" : "$agente",'
            '"remitente" : "$remitente",'
            '"direccion_partida" : "$direccion_partida",'
            '"destinatario":"$destinatario",'
            '"direccion_llegada":"$direccion_llegada",'
            '"conductor":"$conductor",'
            '"vehiculo":"$vehiculo",'
            '"via_tipo":"$via_tipo",'
            '"imagen":"$imagen",'
            '"detalle_guia_rc":$a'
            '}',
        headers: TraerToken.headers);
 print('{'
     '"id_atencion_pedido":"$id_atencion_pedido",'
     '"fecha" : "$fecha",'
     '"traslado" : "$traslado",'
     '"via" : "$via",'
     '"cliente" : "$cliente",'
     '"agente" : "$agente",'
     '"remitente" : "$remitente",'
     '"direccion_partida" : "$direccion_partida",'
     '"destinatario":"$destinatario",'
     '"direccion_llegada":"$direccion_llegada",'
     '"conductor":"$conductor",'
     '"vehiculo":"$vehiculo",'
     '"via_tipo":"$via_tipo",'
     '"imagen":"$imagen",'
     '"detalle_guia_rc":$a'
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

  Future getMailCerrar(nm_solicitud, id_atencion_pedidos) async {
    await TraerToken().mostrarDatos();
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/atenderasignaciones/rest/mail'),
        body:
            '{"numero_solicitud":"$nm_solicitud","id_atencion_pedidos":"$id_atencion_pedidos"}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
    } else if (response.statusCode == 400) {}
  }

  Future<List<ListaDetallePedido>> getBuscarPorpedido(nmSolicitud) async {
    await TraerToken().mostrarDatos();
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil +
            '/atenderasignaciones/rest/buscar-pedido'),
        body: '{"nm_solicitud":"$nmSolicitud"}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final tipocarga = new ListaDetallePedidos.fromJsonList(jsonResponse);
      return tipocarga.items;
    } else if (response.statusCode == 400) {}
    return [];
  }
}
