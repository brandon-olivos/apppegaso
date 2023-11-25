import 'dart:convert';
import 'dart:io';

import 'package:Pegaso/src/Pages/Login/modelLogin.dart';
import 'package:Pegaso/src/data/db/token.dart';
import 'package:Pegaso/src/data/models/ListaSeguimientoAgente.dart';
import 'package:Pegaso/src/data/models/ListaSeguimientoNuevo.dart';
import 'package:Pegaso/src/data/models/ListaseguimientoAgRC.dart';
import 'package:Pegaso/src/data/models/grclienteseguimiento.dart';
import 'package:Pegaso/src/data/models/estados.dart';
import 'package:Pegaso/src/data/provider/TraerToken.dart';
import 'package:Pegaso/src/util/app-config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

// Trabajador trabajador;
var dato;

class ProviderLista {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  //22/11/2022
  Future<List<ListaSeguimientoNuevos>> getListaSeguimientoNuevo(valor) async {
    await TraerToken().mostrarDatos();

    http.Response response = await http.post(
        Uri.parse(
            AppConfig.urlBackendMovil + '/seguimientoauxiliar/rest/listanueva'),
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
  Future<List<GRClienteSeguimiento>> getlistaguiacliente(idGuiaRemision) async {
    await TraerToken().mostrarDatos();

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil +
            '/seguimientoauxiliar/rest/getlistaguiacliente'),
        body: ' {"idGuia":$idGuiaRemision}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadostraba =
          new GRClienteSeguimiento2.fromJsonList(jsonResponse);

      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  //
  //
//
  Future<ListaSeguimientoNuevos> getseguimiento(valob) async {
    await TraerToken().mostrarDatos();
    ListaSeguimientoNuevos as = new ListaSeguimientoNuevos();
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil +
            '/seguimientoauxiliar/rest/getseguimiento'),
        body: '{"id_guia": "$valob"}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final listadostraba = listaSeguimientoNuevosFromJson(response.body);

      return listadostraba[0];
    } else if (response.statusCode == 400) {}
    return as;
  }

  //
  //
  //
  static Future<List<Estados>> get_estados(String query) async {
    await TraerToken().mostrarDatos();
    final url = Uri.parse(
      AppConfig.urlBackendMovil + '/seguimientoauxiliar/rest/estados',
    );
    final response = await http.get(url, headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final List users = json.decode(response.body);

      return users.map((json) => Estados.fromJson(json)).where((user) {
        final nameLower = user.nombre_estado.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  //
  ///
  /////
  ///
  ///
  Future<int> editarGRPegasoSeguimiento(
      {comentario = '', id_estado, id_guia_remision}) async {
    await TraerToken().mostrarDatos();

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil +
            '/seguimientoauxiliar/rest/updategpegaso'),
        body: '{'
            '"id_guia_remision": $id_guia_remision,'
            '"id_estado": $id_estado,'
            '"comentario": "$comentario"'
            '}',
        headers: TraerToken.headers);

    print('{'
        '"id_guia_remision": $id_guia_remision,'
        '"id_estado": $id_estado,'
        '"comentario": "$comentario"'
        '}');

    print(TraerToken.headers);
    print(response.body);
    if (response.statusCode == 200) {
      await DatabasePr.db.eliminarTodo();
      return response.statusCode;
    } else if (response.statusCode == 400) {
      return response.statusCode;
    }

    if (response.statusCode == 200) {
    } else if (response.statusCode == 400) {}
  }
  //
  //
  //
  //

  Future<int> editarGRClienteSeguimiento(
      {
      //hora_entrega,
      fecha_cargo = '',
      fecha_hora_entrega = '',
      observacion = '',
      id_estado_mercaderia,
      entregado_por = '',
      recibido_por = '',
      id_estado_cargo,
      id_guia_remision_cliente}) async {
    await TraerToken().mostrarDatos();

    http.Response response = await http.post(
        Uri.parse(
            AppConfig.urlBackendMovil + '/seguimientoauxiliar/rest/updategc'),
        body: '{'
            '"id_guia_remision_cliente": $id_guia_remision_cliente,'
            '"id_estado_cargo": $id_estado_cargo,'
            '"recibido_por": "$recibido_por",'
            '"entregado_por": "$entregado_por",'
            '"id_estado_mercaderia": $id_estado_mercaderia,'
            '"observacion": "$observacion",'
            '"fecha_hora_entrega": "$fecha_hora_entrega",'
            '"fecha_cargo": "$fecha_cargo"'
            //'"hora_entrega": "$hora_entrega"'
            '}',
        headers: TraerToken.headers);

    print('{'
        '"id_guia_remision_cliente": $id_guia_remision_cliente,'
        '"id_estado_cargo": $id_estado_cargo,'
        '"recibido_por": "$recibido_por",'
        '"entregado_por": "$entregado_por",'
        '"id_estado_mercaderia": $id_estado_mercaderia,'
        '"observacion": "$observacion",'
        '"fecha_hora_entrega": "$fecha_hora_entrega",'
        '"fecha_cargo": "$fecha_cargo"'
        '}');

    print(TraerToken.headers);
    print(response.body);
    if (response.statusCode == 200) {
      await DatabasePr.db.eliminarTodo();
      return response.statusCode;
    } else if (response.statusCode == 400) {
      return response.statusCode;
    }

    if (response.statusCode == 200) {
    } else if (response.statusCode == 400) {}
  }

//22/11/2022

  Future<List<ListaSeguimientoAgente>> getListaSeguimientoAgente(
      {String busca = ''}) async {
    await TraerToken().mostrarDatos();

    http.Response response = await http.post(
        Uri.parse(
            AppConfig.urlBackendMovil + '/seguimientoauxiliar/rest/lista'),
        headers: TraerToken.headers,
        body: '{"buscar" : "$busca"}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadostraba =
          new ListaSeguimientoAgentes.fromJsonList(jsonResponse["data"]);

      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<List<ListaSeguimientoAgente>> getListaSeguimientoAuxiliar(
      {String busca = ''}) async {
    await TraerToken().mostrarDatos();

    http.Response response = await http.post(
        Uri.parse(
            AppConfig.urlBackendMovil + '/seguimientoauxiliar/rest/lista'),
        headers: TraerToken.headers,
        body: '{"buscar" : "$busca"}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final listadostraba =
          new ListaSeguimientoAgentes.fromJsonList(jsonResponse["data"]);

      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<List<ListaSeguimientoAgente>> getListaSeguimientoAuxiliarAte(
      {String busca = ''}) async {
    await TraerToken().mostrarDatos();

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil +
            '/seguimientoauxiliar/rest/listaatendido'),
        headers: TraerToken.headers,
        body: '{"buscar" : "$busca"}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadostraba =
          new ListaSeguimientoAgentes.fromJsonList(jsonResponse["data"]);

      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<List<ListaSeguimientoAgente>> getListaSeguimientoAgenteAte(
      {String busca = ''}) async {
    await TraerToken().mostrarDatos();

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil +
            '/seguimientoagente/rest/listaatendido'),
        headers: TraerToken.headers,
        body: '{"buscar" : "$busca"}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadostraba =
          new ListaSeguimientoAgentes.fromJsonList(jsonResponse["data"]);

      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<List<ListaSeguimientoAgente>> getListaSeguimientoAgenteBuscar(
      {String busca = ''}) async {
    await TraerToken().mostrarDatos();

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil +
            '/seguimientoagente/rest/listaatendidobusca'),
        headers: TraerToken.headers,
        body: '{"buscar" : "$busca"}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadostraba =
          new ListaSeguimientoAgentes.fromJsonList(jsonResponse["data"]);

      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<List<ListaSeguimientoAgente>> getListaSeguimientoAuxiliarBuscar(
      {String busca = ''}) async {
    await TraerToken().mostrarDatos();

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil +
            '/seguimientoauxiliar/rest/listaatendidobusca'),
        headers: TraerToken.headers,
        body: '{"buscar" : "$busca"}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadostraba =
          new ListaSeguimientoAgentes.fromJsonList(jsonResponse["data"]);

      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<List<ListaseguimientoAgRC>> getConsultaGuiasRCAux(
      idGuiaRem, tipoGuia) async {
    await TraerToken().mostrarDatos();

    http.Response response = await http.post(
        Uri.parse(
            AppConfig.urlBackendMovil + '/seguimientoauxiliar/rest/guias'),
        body: '{"idGuiaRem":$idGuiaRem,'
            '"tipoGuia":"$tipoGuia"}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadostraba =
          new ListaseguimientoAgRCs.fromJsonList(jsonResponse["data"]);

      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<List<ListaseguimientoAgRC>> getConsultaGuiasRC(
      idGuiaRem, tipoGuia) async {
    await TraerToken().mostrarDatos();

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/seguimientoagente/rest/guias'),
        body: '{"idGuiaRem":$idGuiaRem,'
            '"tipoGuia":"$tipoGuia"}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadostraba =
          new ListaseguimientoAgRCs.fromJsonList(jsonResponse["data"]);

      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<List<TokenUsuario>> getUnidadesTerr() async {
    return List.empty();
  }

  bool isSaving = false;
  File newPictureFile;

  void updateSelectedProductImage(String path) {
    //this.selectedProduct.picture = path;
    this.newPictureFile = File.fromUri(Uri(path: path));

    //  notifyListeners();
  }

  Future<String> subirImagen(
      {idGuiaRem, idGuia, tipo, comentario, imagen, recibido_por}) async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd H:m:s');
    String fechaReguistro = formatter.format(now);

    http.Response response = await http.post(
        Uri.parse(
            AppConfig.urlBackendMovil + '/seguimientoauxiliar/rest/subir'),
        body: '{"tipo":"$tipo",'
            '"idGuia":"$idGuia",'
            '"comentario":"$comentario",'
            '"fechaReguistro":"$fechaReguistro",'
            '"imagen":"$imagen",'
            '"recibido_por":"$recibido_por"'
            '}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
    } else if (response.statusCode == 400) {}
    return '';
  }

  Future getLogin() async {
    await TraerToken().mostrarDatos();
    http.Response response = await http.get(
        Uri.parse(AppConfig.urlBackendMovil + '/login/rest/data'),
        headers: TraerToken.headers);
    final jsonResponse = json.decode(response.body);
    return jsonResponse["perfil_nombre"].toString();
  }

  Future getLoginUusario() async {
    await TraerToken().mostrarDatos();
    http.Response response = await http.get(
        Uri.parse(AppConfig.urlBackendMovil + '/login/rest/data'),
        headers: TraerToken.headers);
    final jsonResponse = json.decode(response.body);
    return jsonResponse["usuario"].toString();
  }

  Future getDatosUsario() async {
    await TraerToken().mostrarDatos();
    http.Response response = await http.get(
        Uri.parse(AppConfig.urlBackendMovil + '/login/rest/data'),
        headers: TraerToken.headers);
    final jsonResponse = json.decode(response.body);
    return jsonResponse["usuario"].toString();
  }
}
