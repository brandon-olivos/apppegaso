import 'dart:convert';

import 'package:Pegaso/src/data/models/Areas.dart';
import 'package:Pegaso/src/data/models/Auxiliar.dart';
import 'package:Pegaso/src/data/models/ListaPedidoClienteOp.dart';
import 'package:Pegaso/src/data/models/PedidoCliente.dart';
import 'package:Pegaso/src/data/models/TipoUnidad.dart';
import 'package:Pegaso/src/data/models/fraguil.dart';
import 'package:Pegaso/src/data/models/tipoServicio.dart';
import 'package:Pegaso/src/data/provider/TraerToken.dart';
import 'package:Pegaso/src/util/app-config.dart';
import 'package:http/http.dart' as http;

var dato;

class ProviderPedidoClienteOp {
  Future<List<ListaPedidoClienteOp>> getListapedidoclienteop(
      {String busca = ''}) async {
    await TraerToken().mostrarDatos();

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/pedidoclienteop/rest/lista'),
        headers: TraerToken.headers,
        body: '{"buscar" : "$busca"}');
    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadostraba =
          new ListaPedidoClienteOps.fromJsonList(jsonResponse["data"]);
      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<List<TipoServicio>> getTipoServicio() async {
    http.Response response = await http.get(
        Uri.parse(
            AppConfig.urlBackendMovil + '/pedidoclienteop/rest/tipo-servicio'),
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final vias = new TipoServicios.fromJsonList(jsonResponse);
      return vias.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<List<Areas>> getAreas() async {
    http.Response response = await http.get(
        Uri.parse(AppConfig.urlBackendMovil + '/pedidoclienteop/rest/areas'),
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final vias = new Areass.fromJsonList(jsonResponse);
      return vias.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<List<TipoUnidad>> getTipoUnidad() async {
    http.Response response = await http.get(
        Uri.parse(
            AppConfig.urlBackendMovil + '/pedidoclienteop/rest/tipo-unidad'),
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final vias = new TipoUnidads.fromJsonList(jsonResponse);
      return vias.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<List<Fragil>> getFragil() async {
    http.Response response = await http.get(
        Uri.parse(AppConfig.urlBackendMovil + '/pedidoclienteop/rest/fragil'),
        headers: TraerToken.headers);
    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final vias = new Fragils.fromJsonList(jsonResponse);
      return vias.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<List<Fragil>> getEsoka() async {
    http.Response response = await http.get(
        Uri.parse(AppConfig.urlBackendMovil + '/pedidoclienteop/rest/estoca'),
        headers: TraerToken.headers);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final vias = new Fragils.fromJsonList(jsonResponse);

      return vias.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<List<Fragil>> getEstalisto() async {
    http.Response response = await http.get(
        Uri.parse(
            AppConfig.urlBackendMovil + '/pedidoclienteop/rest/esta-listo'),
        headers: TraerToken.headers);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final vias = new Fragils.fromJsonList(jsonResponse);

      return vias.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<List<Auxiliar>> getAuxilitar() async {
    http.Response response = await http.get(
        Uri.parse(
            AppConfig.urlBackendMovil + '/pedidoclienteop/rest/lista-auxiliar'),
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final vias = new Auxiliars.fromJsonList(jsonResponse);

      return vias.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future guardar(PedidoCliente pedidoCliente) async {
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/pedidoclienteop/rest/create'),
        headers: TraerToken.headers,
        body: '{"id_remitente" : "${pedidoCliente.id_remitente}",'
            '"id_cliente" : "${pedidoCliente.id_cliente}",'
            '"nm_solicitud" : "${pedidoCliente.nm_solicitud}",'
            '"fecha" : "${pedidoCliente.fecha}",'
            '"hora_recojo" : "${pedidoCliente.hora_recojo}",'
            '"tipo_servicio" : "${pedidoCliente.tipo_servicio}",'
            '"id_direccion_recojo" : "${pedidoCliente.id_direccion_recojo}",'
            '"contacto" : "${pedidoCliente.contacto}",'
            '"id_area" : "${pedidoCliente.id_area}",'
            '"referencia" : "${pedidoCliente.referencia}",'
            '"telefono" : "${pedidoCliente.telefono}",'
            '"cantidad_personal" : "${pedidoCliente.cantidad_personal}",'
            '"id_tipo_unidad" : "${pedidoCliente.id_tipo_unidad}",'
            '"stoka" : "${pedidoCliente.stoka}",'
            '"fragil" : "${pedidoCliente.fragil}",'
            '"cantidad" : "${pedidoCliente.cantidad}",'
            '"peso" : "${pedidoCliente.peso}",'
            '"alto" : "${pedidoCliente.alto}",'
            '"ancho" : "${pedidoCliente.ancho}",'
            '"largo" : "${pedidoCliente.largo}",'
            '"estado_mercaderia" : "${pedidoCliente.estado_mercaderia}",'
            '"observacion" : "${pedidoCliente.observacion}",'
            '"notificacion" : "${pedidoCliente.notificacion}",'
            '"notificacion_descarga" : "${pedidoCliente.notificacion_descarga}",'
            '"auxiliar" : "${pedidoCliente.auxiliar}",'
            '"conductor" : "${pedidoCliente.idConductor}",'
            '"vehiculo" : "${pedidoCliente.vehiculo}"}');

    if (response.statusCode == 200) {
      return response.statusCode;
    } else if (response.statusCode == 400) {}
    return response.statusCode;
  }

  Future editar(ListaPedidoClienteOp pedidoCliente) async {
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/pedidoclienteop/rest/editar'),
        headers: TraerToken.headers,
        body: '{"id_pedido_cliente" : "${pedidoCliente.id_pedido_cliente}",'
            '"fecha" : "${pedidoCliente.fecha}",'
            '"hora_recojo" : "${pedidoCliente.hora_recojo}",'
            '"id_tipo_servicios" : "${pedidoCliente.id_tipo_servicios}",'
            '"id_cliente" : "${pedidoCliente.id_cliente}",'
            '"id_remitente" : "${pedidoCliente.id_remitente}",'
            '"id_direccion_recojo" : "${pedidoCliente.id_direccion_recojo}",'
            '"contacto" : "${pedidoCliente.contacto}",'
            '"id_area" : "${pedidoCliente.id_area}",'
            '"referencia" : "${pedidoCliente.referencia}",'
            '"telefono" : "${pedidoCliente.telefono}",'
            '"cantidad_personal" : "${pedidoCliente.cantidad_personal}",'
            '"id_tipo_unidad" : "${pedidoCliente.id_tipo_unidad}",'
            '"stoka" : "${pedidoCliente.stoka}",'
            '"fragil" : "${pedidoCliente.fragil}",'
            '"cantidad" : "${pedidoCliente.cantidad}",'
            '"peso" : "${pedidoCliente.peso}",'
            '"alto" : "${pedidoCliente.alto}",'
            '"ancho" : "${pedidoCliente.ancho}",'
            '"largo" : "${pedidoCliente.largo}",'
            '"estado_mercaderia" : "${pedidoCliente.estado_mercaderia}",'
            '"observacion" : "${pedidoCliente.observacion}",'
            '"id_atencion_pedidos" : "${pedidoCliente.id_atencion_pedidos}",'
            //'"notificacion_descarga" : "${pedidoCliente.notificacion_descarga}",'
            '"auxiliar" : "${pedidoCliente.idAuxiliar}",'
            '"conductor" : "${pedidoCliente.id_conductor}",'
            '"vehiculo" : "${pedidoCliente.idUnidad}"}');

    print('{"id_pedido_cliente" : "${pedidoCliente.id_pedido_cliente}",'
        '"fecha" : "${pedidoCliente.fecha}",'
        '"hora_recojo" : "${pedidoCliente.hora_recojo}",'
        '"id_tipo_servicios" : "${pedidoCliente.id_tipo_servicios}",'
        '"id_cliente" : "${pedidoCliente.id_cliente}",'
        '"id_remitente" : "${pedidoCliente.id_remitente}",'
        '"id_direccion_recojo" : "${pedidoCliente.id_direccion_recojo}",'
        '"contacto" : "${pedidoCliente.contacto}",'
        '"id_area" : "${pedidoCliente.id_area}",'
        '"referencia" : "${pedidoCliente.referencia}",'
        '"telefono" : "${pedidoCliente.telefono}",'
        '"cantidad_personal" : "${pedidoCliente.cantidad_personal}",'
        '"id_tipo_unidad" : "${pedidoCliente.id_tipo_unidad}",'
        '"stoka" : "${pedidoCliente.stoka}",'
        '"fragil" : "${pedidoCliente.fragil}",'
        '"cantidad" : "${pedidoCliente.cantidad}",'
        '"peso" : "${pedidoCliente.peso}",'
        '"alto" : "${pedidoCliente.alto}",'
        '"ancho" : "${pedidoCliente.ancho}",'
        '"largo" : "${pedidoCliente.largo}",'
        '"estado_mercaderia" : "${pedidoCliente.estado_mercaderia}",'
        '"observacion" : "${pedidoCliente.observacion}",'
        '"id_atencion_pedidos" : "${pedidoCliente.id_atencion_pedidos}",'
        '"auxiliar" : "${pedidoCliente.idAuxiliar}",'
        '"conductor" : "${pedidoCliente.id_conductor}",'
        '"vehiculo" : "${pedidoCliente.idUnidad}"}');
    print(response.body);
    if (response.statusCode == 200) {
      return response.statusCode;
    } else if (response.statusCode == 400) {}
    return response.statusCode;
  }
}
