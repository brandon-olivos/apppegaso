// ignore_for_file: missing_return

import 'package:Pegaso/src/data/models/TipoDocumento.dart';
import 'package:Pegaso/src/data/models/entidades.dart';
import 'package:Pegaso/src/data/provider/TraerToken.dart';
import 'package:Pegaso/src/util/app-config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProviderEntidades {
  TraerToken _traerToken = new TraerToken();

  Future<List<Entidad>> getEntidades(query) async {
    final url = Uri.parse(
      AppConfig.urlBackendMovil + '/entidades/rest/entidades',
    );
    final response = await http.get(
      url,
      headers: TraerToken.headers,
      // body: '{"razon_socialR": "$query"}',
    );

    if (response.statusCode == 200) {
      final List users = json.decode(response.body);

      return users.map((json) => Entidad.fromJsonLis(json)).where((user) {
        final nameLower = user.razon_social.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<Entidad>> getEntidadesS({String query}) async {
    final url = Uri.parse(
      AppConfig.urlBackendMovil + '/entidades/rest/entidades',
    );

    final response = await http.post(
      url,
      headers: TraerToken.headers,
      body: '{"razon_social": "$query"}',
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print("aqiuiiiiii1111");
      print(jsonResponse);
      final listadostraba = new ListaEntidad.fromJsonList(jsonResponse);
      print("aqiuiiiiii5555");
      return listadostraba.items;
    } else {
      throw Exception();
    }
  }

  Future<List<TipoDocumento>> getTipoDocumento() async {
    http.Response response = await http.get(
        Uri.parse(AppConfig.urlBackendMovil + '/entidades/rest/tipo-documento'),
        headers: TraerToken.headers);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final vias = new ListaTipoDocumento.fromJsonList(jsonResponse);

      return vias.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<int> guardar(Entidad entidad) async {
    print(jsonDecode(jsonEncode(entidad)));
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/entidades/rest/create'),
        body: jsonEncode(entidad),
        headers: TraerToken.headers);
    print(response.body);
    if (response.statusCode == 200) {
      return response.statusCode;

      ///await DatabasePr.db.eliminarTodo();
    } else if (response.statusCode == 400) {
      return response.statusCode;
    }
  }

  Future<int> delete(Entidad entidad) async {
    print(jsonDecode(jsonEncode(entidad)));
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/entidades/rest/delete'),
        body: jsonEncode(entidad),
        headers: TraerToken.headers);
    print(response.body);
    if (response.statusCode == 200) {
      return response.statusCode;

      ///await DatabasePr.db.eliminarTodo();
    } else if (response.statusCode == 400) {
      return response.statusCode;
    }
  }

  Future<List<TipoDocumento>> getTipoDocumentoPorId(Entidad entidad) async {
    http.Response response = await http.post(
        Uri.parse(
            AppConfig.urlBackendMovil + '/entidades/rest/tipo-documentopor-id'),
        headers: TraerToken.headers,
        body: jsonEncode(entidad));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final vias = new ListaTipoDocumento.fromJsonList(jsonResponse);
      return vias.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<int> editar(Entidad entidad) async {
    print(jsonDecode(jsonEncode(entidad)));
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/entidades/rest/update'),
        body: jsonEncode(entidad),
        headers: TraerToken.headers);
    print(response.body);
    if (response.statusCode == 200) {
      return response.statusCode;
    } else if (response.statusCode == 400) {
      return response.statusCode;
    }
  }

  Future buscarEntidad(nmrDocumento) async {
    print("nmrDocumento $nmrDocumento");
    var cantidad = 0;
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/entidades/rest/buscar-entidad'),
        body: '{"nmrDocumento": "$nmrDocumento"}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      cantidad = response.body.length;
      return cantidad;
    } else if (response.statusCode == 400) {
      cantidad = response.body.length;
      return cantidad;
    }
    cantidad = response.body.length;
    return cantidad;
  }
}
