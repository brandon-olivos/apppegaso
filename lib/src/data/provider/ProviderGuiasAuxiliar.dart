// ignore_for_file: missing_return

import 'dart:convert';

import 'package:Pegaso/src/data/db/token.dart';
import 'package:Pegaso/src/data/models/GuiaRemAux.dart';

import 'package:Pegaso/src/data/models/TipoCarga.dart';
import 'package:Pegaso/src/data/models/TipoViaCarga.dart';
import 'package:Pegaso/src/data/models/agente.dart';
import 'package:Pegaso/src/data/models/conductor.dart';

import 'package:Pegaso/src/data/models/entidades.dart';

import 'package:Pegaso/src/data/models/listaAsignacion.dart';
import 'package:Pegaso/src/data/models/Via.dart';
import 'package:Pegaso/src/data/models/listaDetallePedido.dart';
import 'package:Pegaso/src/data/models/listaGuiasPend.dart';
import 'package:Pegaso/src/data/models/listaGuiasRem.dart';
import 'package:Pegaso/src/data/models/transportista.dart';
import 'package:Pegaso/src/data/models/vehiculo.dart';
import 'package:Pegaso/src/data/provider/TraerToken.dart';
import 'package:Pegaso/src/util/app-config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;

var dato;

class ProviderGuiasAuxiliar {
  Future<String> editarGuiaRMAux(
      {id_guia_remision,
      serie,
      numero_guia,
      fecha,
      fecha_traslado,
      id_via,
      id_tipo_via,
      //id_cliente,
      id_agente,
      id_remitente,
      id_direccion_partida,
      id_destinatario,
      id_direccion_llegada,
      id_conductor,
      id_vehiculo,
      transportista,
      guia_remision_transportista,
      factura_transportista,
      importe_transportista,
      comentario_transportista}) async {
    await TraerToken().mostrarDatos();

    // var a = await DatabasePr.db.getDtaGRCjs();

    http.Response response = await http.post(
        Uri.parse(
            AppConfig.urlBackendMovil + '/guiaremisionaux/rest/editar-guia-a'),
        body: '{'
            '"id_guia_remision":"$id_guia_remision",'
            '"serie":"$serie",'
            '"numero_guia":"$numero_guia",'
            '"fecha":"$fecha",'
            '"fecha_traslado":"$fecha_traslado",'
            '"id_via":"$id_via",'
            '"id_tipo_via":"$id_tipo_via",'
            //'"id_cliente":"$id_cliente",'
            '"id_agente":"$id_agente",'
            '"id_remitente":"$id_remitente",'
            '"id_direccion_partida":"$id_direccion_partida",'
            '"id_destinatario":"$id_destinatario",'
            '"id_direccion_llegada":"$id_direccion_llegada",'
            '"id_conductor":"$id_conductor",'
            '"id_vehiculo":"$id_vehiculo",'
            '"transportista":"$transportista",'
            '"guia_remision_transportista":"$guia_remision_transportista",'
            '"factura_transportista":"$factura_transportista",'
            '"importe_transportista":"$importe_transportista",'
            '"comentario_transportista":"$comentario_transportista"'
            '}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      /// await DatabasePr.db.eliminarTodo();
    } else if (response.statusCode == 400) {}
  }

  // ignore: non_constant_identifier_names
  Future<String> GuardarGuiaRMAux({GuiaRemAux guiaRemAux}) async {
    await TraerToken().mostrarDatos();

    var a = await DatabasePr.db.getDtaGRCjs();

    http.Response response = await http.post(
        Uri.parse(
            AppConfig.urlBackendMovil + '/guiaremisionaux/rest/crear-guia-a'),
        body: '{'
            //   '"id_guia_remision":"$id_guia_remision",'
            '"serie":"${guiaRemAux.serie}",'
            '"numero_guia":"${guiaRemAux.numeroGuia}",'
            '"fecha":"${guiaRemAux.fecha}",'
            '"fecha_traslado":"${guiaRemAux.fechaTraslado}",'
            '"id_via":"${guiaRemAux.idVia}",'
            '"id_tipo_via":"${guiaRemAux.idTipoVia}",'
            '"id_cliente":"${guiaRemAux.idCliente}",'
            '"id_agente":"${guiaRemAux.idAgente}",'
            '"id_remitente":"${guiaRemAux.idRemitente}",'
            '"id_direccion_partida":"${guiaRemAux.idDireccionPartida}",'
            '"id_destinatario":"${guiaRemAux.idDestinatario}",'
            '"id_direccion_llegada":"${guiaRemAux.idDireccionLlegada}",'
            '"id_conductor":"${guiaRemAux.idConductor}",'
            '"id_vehiculo":"${guiaRemAux.idVehiculo}",'
            '"transportista":"${guiaRemAux.idTransportista}",'
            '"guia_remision_transportista":"${guiaRemAux.guiaRemisionTransportista}",'
            '"factura_transportista":"${guiaRemAux.facturaTransportista}",'
            '"importe_transportista":"${guiaRemAux.importeTransportista}",'
            '"comentario_transportista":"${guiaRemAux.comentarioTransportista}",'
            '"detalle_guia_rc":$a'
            '}',
        headers: TraerToken.headers);

    print(response.body);
    if (response.statusCode == 200) {
      await DatabasePr.db.eliminarTodo();
    } else if (response.statusCode == 400) {}
  }

  static Future<List<Conductor>> getDSuggestionsconductor(String query) async {
    await TraerToken().mostrarDatos();
    final url = Uri.parse(
      AppConfig.urlBackendMovil + '/guiaremisionaux/rest/conductor',
    );
    final response = await http.get(url, headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final List users = json.decode(response.body);

      return users.map((json) => Conductor.fromJson(json)).where((user) {
        final nameLower = user.empleado.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  static Future<List<Vehiculo>> getDSuggestionsvehiculo(String query) async {
    await TraerToken().mostrarDatos();
    final url = Uri.parse(
      AppConfig.urlBackendMovil + '/guiaremisionaux/rest/vehiculo',
    );
    final response = await http.get(url, headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final List users = json.decode(response.body);

      return users.map((json) => Vehiculo.fromJson(json)).where((user) {
        final nameLower = user.descripcion.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  static Future<List<Transportista>> getDSuggestionstransportista(
      String query) async {
    await TraerToken().mostrarDatos();
    final url = Uri.parse(
      AppConfig.urlBackendMovil + '/guiaremisionaux/rest/transportista',
    );
    final response = await http.get(url, headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final List users = json.decode(response.body);

      return users.map((json) => Transportista.fromJson(json)).where((user) {
        final nameLower = user.razonSocial.toLowerCase();
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

  Future<List<ListaGuiasRem>> getListaGuiasAuxiliar(valob) async {
    await TraerToken().mostrarDatos();
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/guiaremisionaux/rest/lista'),
        body: '{"buscar": "$valob"}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadostraba =
          new ListaGuiasRem2.fromJsonList(jsonResponse["data"]);

      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<GuiaRemAux> getGuiaAuxiliar(valob) async {
    await TraerToken().mostrarDatos();
    GuiaRemAux as = new GuiaRemAux();
    http.Response response = await http.post(
        Uri.parse(
            AppConfig.urlBackendMovil + '/guiaremisionaux/rest/guia-rem-aux'),
        body: '{"idGuiaRem": "$valob"}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final listadostraba = guiaRemAuxFromJson(response.body);

      return listadostraba[0];
    } else if (response.statusCode == 400) {}
    return as;
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

  Future<List<Via>> getVia() async {
    http.Response response = await http.get(
        Uri.parse(AppConfig.urlBackendMovil + '/atenderasignaciones/rest/via'),
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final vias = new Vias.fromJsonList(jsonResponse["data"]);
      return vias.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<List<TipoViaCarga>> getTipoViaCarga(via) async {
    await TraerToken().mostrarDatos();
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil +
            '/atenderasignaciones/rest/tipo-via-carga'),
        body: '{"via":$via}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final vias = new TipoViaCargas.fromJsonList(jsonResponse["data"]);
      return vias.items;
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

  Future<List<ListaDetallePedido>> getBuscarPorpedido(nmSolicitud) async {
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
