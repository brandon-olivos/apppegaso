import 'dart:convert';

import 'package:Pegaso/src/data/db/token.dart';

import 'package:Pegaso/src/data/models/TipoCarga.dart';
import 'package:Pegaso/src/data/models/TipoViaCarga.dart';
import 'package:Pegaso/src/data/models/Tipocomprobante.dart';
import 'package:Pegaso/src/data/models/agente.dart';
import 'package:Pegaso/src/data/models/conductor.dart';
import 'package:Pegaso/src/data/models/direccion.dart';

import 'package:Pegaso/src/data/models/entidades.dart';
import 'package:Pegaso/src/data/models/guiaCliente.dart';

import 'package:Pegaso/src/data/models/listaAsignacion.dart';
import 'package:Pegaso/src/data/models/Via.dart';
import 'package:Pegaso/src/data/models/listaDetallePedido.dart';
import 'package:Pegaso/src/data/models/listaGuiasPend.dart';
import 'package:Pegaso/src/data/provider/TraerToken.dart';
import 'package:Pegaso/src/util/app-config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;

class ProviderProcesarGuias {
  Future eliminarGuiaCliente(id) async {
    await TraerToken().mostrarDatos();
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/procesarguias/rest/delete-gc'),
        body: '{"idGuiaCliente":$id}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<String> registrarGuiaCliente({
    id_guia_remision,
    grs,
    gr,
    ft,
    oc,
    id_tipo_carga,
    descripcion = '',
    cantidad,
    peso,
    volumen,
    alto,
    largo = '',
    ancho,
  }) async {
    await TraerToken().mostrarDatos();

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil +
            '/procesarguias/rest/crear-guia-cliente'),
        body: '{'
            '"id_guia_remision": "$id_guia_remision",'
            '"grs": "$grs",'
            '"gr": "$gr",'
            '"ft": "$ft",'
            '"oc": "$oc",'
            '"id_tipo_carga": "$id_tipo_carga",'
            '"descripcion": "$descripcion",'
            '"cantidad": "$cantidad",'
            '"peso": "$peso",'
            '"volumen": "$volumen",'
            '"alto": "$alto",'
            '"largo": "$largo",'
            '"ancho": "$ancho"'
            '}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
    } else if (response.statusCode == 400) {}
  }

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  DateTime currentDate = DateTime.now();
  DateTime nowfec = new DateTime.now();
  DateTime nowtras = new DateTime.now();

  Future<String> editarGuiaCliente(
      {
      // id_guia_remision,
      grs,
      gr,
      ft,
      oc,
      id_tipo_carga,
      descripcion = '',
      cantidad,
      peso,
      volumen,
      alto,
      largo,
      ancho,
      id_guia_cliente}) async {
    await TraerToken().mostrarDatos();

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/procesarguias/rest/update-gc'),
        body: '{'
            '"idGuiaCliente": "$id_guia_cliente",'
            '"grs": "$grs",'
            '"gr": "$gr",'
            '"ft": "$ft",'
            '"oc": "$oc",'
            '"ancho": "$ancho",'
            '"largo": "$largo",'
            '"peso": "$peso",'
            '"alto": "$alto",'
            '"cantidad": "$cantidad",'
            '"volumen": "$volumen",'
            '"descripcion": "$descripcion",'
            '"id_tipo_carga": $id_tipo_carga'
            '}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
    } else if (response.statusCode == 400) {}
  }

  Future<List<GuiaCliente>> getListaGuiasCliente(idGuiaRem) async {
    await TraerToken().mostrarDatos();

    http.Response response = await http.post(
        Uri.parse(
            AppConfig.urlBackendMovil + '/procesarguias/rest/guia-cliente'),
        body: ' {"idGuia":$idGuiaRem}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadostraba = new ListaGuiasClientes.fromJsonList(jsonResponse);

      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  static Future<List<TipoComprobante>> getDSuggestionstipocomprobante(
      String query) async {
    await TraerToken().mostrarDatos();
    final url = Uri.parse(
      AppConfig.urlBackendMovil + '/guiaremisionaux/rest/tipocomprobante',
    );
    final response = await http.get(url, headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final List users = json.decode(response.body);

      return users.map((json) => TipoComprobante.fromJson(json)).where((user) {
        final nameLower = user.descripcion.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<ListaGuiasPend>> getListaGuiasPend(valob) async {
    await TraerToken().mostrarDatos();
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/procesarguias/rest/lista'),
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

  static Future<List<Agente>> getUserSuggestions(String query) async {
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

  static Future<List<Entidad>> getEndidadSugPen(String query) async {
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

  Future<String> editarGuia(
      {fecha,
      traslado,
      via,
      cliente,
      agente,
      remitente,
      id_guia_rem,
      destinatario = '',
      direccion_llegada,
      conductor,
      vehiculo,
      via_tipo = '',
      // id_atencion_pedido,
      imagen}) async {
    await TraerToken().mostrarDatos();

    // var a = await DatabasePr.db.getDtaGRCjs();

    http.Response response = await http.post(
        Uri.parse(
            AppConfig.urlBackendMovil + '/procesarguias/rest/editar-guia'),
        body: '{'
            '"id_guia_remision":"$id_guia_rem",'
            '"fecha" : "$fecha",'
            '"traslado" : "$traslado",'
            '"via" : "$via",'
            // '"cliente" : "$cliente",'
            '"agente" : "$agente",'

            //'"direccion_partida" : "$direccion_partida",'
            '"destinatario":"$destinatario",'
            '"direccion_llegada":"$direccion_llegada",'
            //'"conductor":"$conductor",'
            //'"vehiculo":"$vehiculo",'
            '"via_tipo":"$via_tipo",'
            '"imagen":"$imagen"'
            //  '"detalle_guia_rc":$a'
            '}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      /// await DatabasePr.db.eliminarTodo();
    } else if (response.statusCode == 400) {}
  }

  Future Delete(id) async {
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/procesarguias/rest/delete'),
        body: '{"idGuiaRemision":$id}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 400) {}
    return response;
  }
}
