import 'dart:convert';

import 'package:Pegaso/src/data/db/detalleRendicionCuentas.dart';
import 'package:Pegaso/src/data/db/token.dart';

import 'package:Pegaso/src/data/models/TipoCarga.dart';
import 'package:Pegaso/src/data/models/TipoViaCarga.dart';
import 'package:Pegaso/src/data/models/agente.dart';

import 'package:Pegaso/src/data/models/entidades.dart';

import 'package:Pegaso/src/data/models/listaAsignacion.dart';
import 'package:Pegaso/src/data/models/Via.dart';
import 'package:Pegaso/src/data/models/listaDetallePedido.dart';
import 'package:Pegaso/src/data/models/listaDetalleRendicionCuenta.dart';
import 'package:Pegaso/src/data/models/listaGuiasPend.dart';
import 'package:Pegaso/src/data/models/listaGuiasRem.dart';
import 'package:Pegaso/src/data/models/listaRendicionCuenta.dart';
import 'package:Pegaso/src/data/provider/TraerToken.dart';
import 'package:Pegaso/src/util/app-config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;

var dato;

class ProviderRendicionCuenta {
  Future<List<ListaRendicionCuenta>> getListaRendidicionCuenta(valob) async {
    await TraerToken().mostrarDatos();

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/rendicioncuentas/rest/lista'),
        body: '{"buscar": "$valob"}',
        headers: TraerToken.headers);
    print(TraerToken.headers);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      final listadostraba =
          new ListaRendicionCuentaes.fromJsonList(jsonResponse["data"]);

      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<String> registrarRendidcion(
      {fecha,
      nmOperacion,
      abonoCuenta,
      diferenciaDepositar,
      //  rinde,
      importeEntregado}) async {
    print(importeEntregado);
    await TraerToken().mostrarDatos();

    var a = await DatabaseDRC.db.getDtjsGRC();

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil +
            '/rendicioncuentas/rest/create-rendicion'),
        body: '{'
            '"fecha":"$fecha",'
            '"nr_operacion" : "$nmOperacion",'
            '"abono_cuenta_de" : "$abonoCuenta",'
            // '"rinde" : "$rinde",'
            '"importe_entregado" : "$importeEntregado",'
            '"diferencia_depositar_reembolsar" : "$diferenciaDepositar",'
            '"flg_estado" : "1",'
            '"detalle_remision_cuenta":$a'
            '}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      await DatabaseDRC.db.eliminarTodo();
      return response.statusCode.toString();
    } else if (response.statusCode == 400) {
      return response.statusCode.toString();
    }
    return response.statusCode.toString();
  }

  Future<List<ListaDetalleRendicionCuenta>> getListaDetalleRendicionCuenta(
      valob) async {
    await TraerToken().mostrarDatos();

    http.Response response = await http.post(
        Uri.parse(
            AppConfig.urlBackendMovil + '/rendicioncuentas/rest/lista-detalle'),
        body: '{"idRendicionCuenta": $valob}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final listadostraba =
          new ListaDetalleRendicionCuentaes.fromJsonList(jsonResponse["data"]);

      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<String> registrarDetalleRendidcion(
      ListaDetalleRendicionCuenta detalle) async {
    print(detalle.concepto);

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil +
            '/rendicioncuentas/rest/create-detalle-rendicion'),
        body: '{'
            '"idRendicionCuentas":"${detalle.idRendicionCuentas}",'
            '"idTipoComprobante":"${detalle.idTipoComprobante}",'
            '"fecha" : "${detalle.fecha}",'
            '"proveedor" : "${detalle.proveedor}",'
            '"ndocumento" :"${detalle.nmDocumento}",'
            '"concepto" : "${detalle.concepto}",'
            '"monto" :"${detalle.monto}"'
            '}',
        headers: TraerToken.headers);

    print(response.body);
    if (response.statusCode == 200) {
      await DatabaseDRC.db.eliminarTodo();
      return response.statusCode.toString();
    } else if (response.statusCode == 400) {
      return response.statusCode.toString();
    }
    return response.statusCode.toString();
  }

  Future<String> deleteDetalleRendidcion(idDetalleRendicionCuentas) async {
    print(idDetalleRendicionCuentas);

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil +
            '/rendicioncuentas/rest/delete-detalle-rendicion'),
        body: '{'
            '"idDetalleRendicionCuentas":"$idDetalleRendicionCuentas"'
            '}',
        headers: TraerToken.headers);
    print('{'
        '"idDetalleRendicionCuentas":"$idDetalleRendicionCuentas"'
        '}');
    print(response.body);
    if (response.statusCode == 200) {
      await DatabaseDRC.db.eliminarTodo();
      return response.statusCode.toString();
    } else if (response.statusCode == 400) {
      return response.statusCode.toString();
    }
    return response.statusCode.toString();
  }

  Future<String> editarRendidcion(ListaRendicionCuenta rendicionCuenta) async {
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil +
            '/rendicioncuentas/rest/edit-rendicion'),
        body: '{'
            '"idRendicionCuentas":"${rendicionCuenta.idRendicionCuentas}",'
            '"importeEntregado" : "${rendicionCuenta.importeEntregado}"'
            '}',
        headers: TraerToken.headers);

    print(response.body);
    if (response.statusCode == 200) {
      await DatabaseDRC.db.eliminarTodo();
      return response.statusCode.toString();
    } else if (response.statusCode == 400) {
      return response.statusCode.toString();
    }
    return response.statusCode.toString();
  }

  Future<String> editarDetRendidcion(
      ListaDetalleRendicionCuenta rendicionCuenta) async {
    print(rendicionCuenta.idDetalleRendicionCuentas);

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil +
            '/rendicioncuentas/rest/edit-detalle-rendicion'),
        body: '{'
            '"idDetalleRendicionCuentas":"${rendicionCuenta.idDetalleRendicionCuentas}",'
            '"idTipoComprobante":"${rendicionCuenta.idTipoComprobante}",'
            '"fecha":"${rendicionCuenta.fecha}",'
            '"proveedor" : "${rendicionCuenta.proveedor}",'
            '"nmDocumento" : "${rendicionCuenta.nmDocumento}",'
            '"concepto" : "${rendicionCuenta.concepto}",'
            '"monto" : "${rendicionCuenta.monto}"'
            '}',
        headers: TraerToken.headers);
    print(response.statusCode);

    if (response.statusCode == 200) {
      return response.statusCode.toString();
    } else if (response.statusCode == 400) {
      return response.statusCode.toString();
    }
    return response.statusCode.toString();
  }
}
