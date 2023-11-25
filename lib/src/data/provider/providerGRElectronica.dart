import 'dart:convert';
import 'package:Pegaso/src/data/db/token.dart';
import 'package:Pegaso/src/data/models/GuiaRemAux.dart';
import 'package:Pegaso/src/data/models/TipoViaCarga.dart';
import 'package:Pegaso/src/data/models/agente.dart';
import 'package:Pegaso/src/data/models/conductor.dart';
import 'package:Pegaso/src/data/models/entidades.dart';
import 'package:Pegaso/src/data/models/Via.dart';
import 'package:Pegaso/src/data/models/listaGuiasRem.dart';
import 'package:Pegaso/src/data/models/transportista.dart';
import 'package:Pegaso/src/data/models/vehiculo.dart';
import 'package:Pegaso/src/data/provider/TraerToken.dart';
import 'package:Pegaso/src/util/app-config.dart';
//import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

var dato;

//LISTA
class ProviderGRElectronica {
  Future<List<ListaGuiasRem>> getListaGuiasAuxiliar(valob) async {
    await TraerToken().mostrarDatos();
    http.Response response = await http.post(
        Uri.parse(
            AppConfig.urlBackendMovil + '/guiaremisionelectronica/rest/lista'),
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

  Future<GuiaRemAux> getVerEstadoGuia(valob) async {
    await TraerToken().mostrarDatos();
    GuiaRemAux as = new GuiaRemAux();

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil +
            '/guiaremisionelectronica/rest/estado-sunat'),
        body: '{"numguia": "$valob"}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final listadostraba = jsonDecode(response.body);
      final qqqq = GuiaRemAux.fromJsonnnnn(listadostraba);
      return qqqq;

      //'{ "id_guia_remision": "2222", "nm_solicitud": "aaaa", "numero_guia": "7777", "serie": "ttette" }');
      // final listadostraba = guiaRemAuxFromJson(response.body);

      //final listadostraba = guiaRemAuxFromJson(jsonEncode(response.body));
      //return listadostraba[0];
      //
    } else if (response.statusCode == 400) {}
    return as;
  }

//DATOS DE GUIA
  Future<GuiaRemAux> getGuiaAuxiliar(valob) async {
    await TraerToken().mostrarDatos();
    GuiaRemAux as = new GuiaRemAux();
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil +
            '/guiaremisionelectronica/rest/datos-guia'),
        body: '{"idGuiaRem": "$valob"}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final listadostraba = guiaRemAuxFromJson(response.body);

      return listadostraba[0];
    } else if (response.statusCode == 400) {}
    return as;
  }

  ////////////
  ///SELECT SIN BUSCAR VIA
  Future<List<Via>> getVia() async {
    http.Response response = await http.get(
        Uri.parse(
            AppConfig.urlBackendMovil + '/guiaremisionelectronica/rest/via'),
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final vias = new Vias.fromJsonList(jsonResponse["data"]);
      return vias.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  ///////////////////////////////////
  /// Select tipo carga
  Future<List<TipoViaCarga>> getTipoViaCarga(via) async {
    await TraerToken().mostrarDatos();
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil +
            '/guiaremisionelectronica/rest/tipo-via-carga'),
        body: '{"via":$via}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final vias = new TipoViaCargas.fromJsonList(jsonResponse["data"]);
      return vias.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  /////////////////////////////////////////////
  //SELECT CON BUSQUEDA CONDUCTOR
  static Future<List<Conductor>> getDSuggestionsconductor(String query) async {
    await TraerToken().mostrarDatos();
    final url = Uri.parse(
      AppConfig.urlBackendMovil + '/guiaremisionelectronica/rest/conductor',
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

  ///////////////////////////////////////////
  ///SELECT BUSQUEDA DE VEHICULOS
  static Future<List<Vehiculo>> getDSuggestionsvehiculo(String query) async {
    await TraerToken().mostrarDatos();
    final url = Uri.parse(
      AppConfig.urlBackendMovil + '/guiaremisionelectronica/rest/vehiculo',
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

  //////////////////////////////////////////
  ///SELECT TRANSPORTISTA BUSQUEDA
  static Future<List<Transportista>> getDSuggestionstransportista(
      String query) async {
    await TraerToken().mostrarDatos();
    final url = Uri.parse(
      AppConfig.urlBackendMovil + '/guiaremisionelectronica/rest/transportista',
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

  ////////////////////////////////////////
  ///SELECT BUSCAR AGENTE
  static Future<List<Agente>> getUserSuggestions(String query) async {
    await TraerToken().mostrarDatos();

    final url = Uri.parse(
      AppConfig.urlBackendMovil + '/guiaremisionelectronica/rest/agente',
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

  ////////////////////////////////////////////////
  ///SELECT BUSCAR ENTIDADES
  static Future<List<Entidad>> getEndidadSuggestions(String query) async {
    await TraerToken().mostrarDatos();
    final url = Uri.parse(
      AppConfig.urlBackendMovil + '/guiaremisionelectronica/rest/entidades',
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

  ///////////////////////////////////////////////
  ///EMITIR GUIA ELECTRONICA
  Future<String> GuardarGuiaRMAux({GuiaRemAux guiaRemAux}) async {
    await TraerToken().mostrarDatos();

    var a = await DatabasePr.db.getDtaGRCjs();

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil +
            '/guiaremisionelectronica/rest/crear-guia-a'),
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
  //////////////////////////////////
  ///

}
