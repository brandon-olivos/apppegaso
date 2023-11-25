import 'package:Pegaso/src/data/db/token.dart';
import 'package:Pegaso/src/data/models/TipoCarga.dart';
import 'package:Pegaso/src/data/models/TipoUnidad.dart';
import 'package:Pegaso/src/data/models/TipoViaCarga.dart';
import 'package:Pegaso/src/data/models/Ubigeos.dart';
import 'package:Pegaso/src/data/models/Via.dart';
import 'package:Pegaso/src/data/models/listaDirecciones.dart';
import 'package:Pegaso/src/data/provider/TraerToken.dart';
import 'package:Pegaso/src/util/app-config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Provider {
  TraerToken _traerToken = new TraerToken();

  Future<List<Via>> getVia() async {
    await _traerToken.mostrarDatos();
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
    await _traerToken.mostrarDatos();
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

  Future<List<TipoCarga>> getTipoCarga() async {
    await _traerToken.mostrarDatos();
    http.Response response = await http.get(
        Uri.parse(
            AppConfig.urlBackendMovil + '/atenderasignaciones/rest/tipo-carga'),
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final tipocarga = new TipoCargas.fromJsonList(jsonResponse["data"]);
      print(tipocarga.items[0].nombreTipoCarga);
      return tipocarga.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future changePassword({password}) async {
    await _traerToken.mostrarDatos();
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/login/rest/change-password'),
        headers: TraerToken.headerslog,
        body: '{"password": "$password"}');
    print({"password": "$password"});
    print(response.body);
    if (response.statusCode == 200) {
      return response.statusCode;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 2.0, color: Colors.grey),
      borderRadius: BorderRadius.all(
          Radius.circular(10.0) //                 <--- border radius here
          ),
    );
  }

  Widget sleccionar(labeltexto, Widget wd) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labeltexto,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(10.0) //                 <--- border radius here
                ),
          ),
          contentPadding: EdgeInsets.all(10),
        ),
        child: ButtonTheme(
            materialTapTargetSize: MaterialTapTargetSize.padded, child: wd),
      ),
    );
  }

  validador(snapshot, ss, dr) {
    if (snapshot.hasData) {
      if (snapshot.hasData == false) {
        return Center(
          child: Text("¡No existen registros"),
        );
      } else {
        final listaPersonalAux = snapshot.data;

        if (listaPersonalAux.length == 0) {
          return Center(
            child: Text("No hay informacion"),
          );
        } else {
          // refreshList();

        }
        return Container(child: sleccionar(ss, dr));
      }
    }
    return snapshot;
  }

  Future<List<ListaDirecciones>> getListaDirecciones(valob) async {
    await TraerToken().mostrarDatos();

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/direcciones/rest/lista'),
        body: '{"buscar": "$valob"}',
        headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      final listadostraba =
          new ListaDireccioness.fromJsonList(jsonResponse["data"]);

      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  static Future<List<Ubigeos>> getUbigeosSuggestions(String query) async {
    await TraerToken().mostrarDatos();
    final url = Uri.parse(
      AppConfig.urlBackendMovil + '/direcciones/rest/ubigeos',
    );
    final response = await http.get(url, headers: TraerToken.headers);

    if (response.statusCode == 200) {
      final List users = json.decode(response.body);

      return users.map((json) => Ubigeos.fromJson(json)).where((user) {
        final nameLower = user.nombreDistrito.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future guardar(ListaDirecciones direcciones) async {
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/direcciones/rest/create'),
        headers: TraerToken.headers,
        body: '{"idEntidad" : "${direcciones.idEntidad}",'
            '"idUbigeo" : "${direcciones.idUbigeo}",'
            '"direccion" : "${direcciones.direccion}",'
            '"urbanizacion" : "${direcciones.urbanizacion}",'
            '"referencia" : "${direcciones.referencia}"}');
    print('{"idEntidad" : "${direcciones.idEntidad}",'
        '"idUbigeo" : "${direcciones.idUbigeo}",'
        '"direccion" : "${direcciones.direccion}",'
        '"urbanizacion" : "${direcciones.urbanizacion}",'
        '"referencia" : "${direcciones.referencia}"}');
    if (response.statusCode == 200) {
      return response.statusCode;
    } else if (response.statusCode == 400) {}
    return response.statusCode;
  }

  Future editarDirecciones(ListaDirecciones direcciones) async {
    print('{"id_direccion" : "${direcciones.idDireccion}",'
        '{"idEntidad" : "${direcciones.idEntidad}",'
        '"idUbigeo" : "${direcciones.idUbigeo}",'
        '"direccion" : "${direcciones.direccion}",'
        '"urbanizacion" : "${direcciones.urbanizacion}",'
        '"referencia" : "${direcciones.referencia}"}');
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/direcciones/rest/update'),
        headers: TraerToken.headers,
        body: '{"id_direccion" : "${direcciones.idDireccion}",'
            '"idEntidad" : ${direcciones.idEntidad},'
            '"idUbigeo" : "${direcciones.idUbigeo}",'
            '"direccion" : "${direcciones.direccion}",'
            '"urbanizacion" : "${direcciones.urbanizacion}",'
            '"referencia" : "${direcciones.referencia}"}');

    print(response.body);
    if (response.statusCode == 200) {
      return response.statusCode;
    } else if (response.statusCode == 400) {}
    return response.statusCode;
  }

  Future<Ubigeos> traerUbigeos(idUbigeo) async {
    http.Response response = await http.post(
        Uri.parse(
            AppConfig.urlBackendMovil + '/direcciones/rest/traer-ubigeos'),
        headers: TraerToken.headers,
        body: '{"id_ubigeo" : "$idUbigeo"}');
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadostraba = new Ubigeos.fromJson(jsonResponse);
      return listadostraba;
    } else if (response.statusCode == 400) {}
    return null;
  }

  Future perfil() {}
}
