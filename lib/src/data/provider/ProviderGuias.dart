import 'dart:convert';

import 'package:Pegaso/src/data/db/token.dart';

import 'package:Pegaso/src/data/models/TipoCarga.dart';
import 'package:Pegaso/src/data/models/TipoViaCarga.dart';
import 'package:Pegaso/src/data/models/agente.dart';

import 'package:Pegaso/src/data/models/entidades.dart';

import 'package:Pegaso/src/data/models/listaAsignacion.dart';
import 'package:Pegaso/src/data/models/Via.dart';
import 'package:Pegaso/src/data/models/listaDetallePedido.dart';
import 'package:Pegaso/src/data/models/listaGuiasPend.dart';
import 'package:Pegaso/src/data/models/listaGuiasRem.dart';
import 'package:Pegaso/src/data/provider/TraerToken.dart';
import 'package:Pegaso/src/util/app-config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;

var dato;

class ProviderGuias {
  Future<List<ListaGuiasPend>> getListaGuiasPend(valob) async {
    await TraerToken().mostrarDatos();

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/guiaremision/rest/lista'),
        body: '{"buscar": "$valob"}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadostraba =
          new ListaGuiasPends.fromJsonList(jsonResponse["data"]);

      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<List<ListaGuiasPend>> getListaGuiasAuxPend(valob) async {
    await TraerToken().mostrarDatos();

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/guiaremisionaux/rest/lista'),
        body: '{"buscar": "$valob"}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadostraba =
          new ListaGuiasPends.fromJsonList(jsonResponse["data"]);

      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<String> registrarGuia(
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

    if (response.statusCode == 200) {
      await DatabasePr.db.eliminarTodo();
    } else if (response.statusCode == 400) {}
  }
}
