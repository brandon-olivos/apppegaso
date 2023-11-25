import 'dart:convert';
import 'package:Pegaso/src/data/models/MControlKilometraje.dart';
import 'package:Pegaso/src/data/provider/TraerToken.dart';
import 'package:Pegaso/src/util/app-config.dart';
import 'package:http/http.dart' as http;

var dato;

class ProviderControlKilometraje {
  Future<List<MControlKilometraje>> getListaControlKilometraje(valob) async {
    await TraerToken().mostrarDatos();

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/controlkilometraje/rest/lista'),
        body: '{"buscar": "$valob"}',
        headers: TraerToken.headers);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      final listaControlKilometraje =
          new ListaControlKilometraje.fromJsonList(jsonResponse["data"]);

      return listaControlKilometraje.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<String> registrarControlKilometraje(
      MControlKilometraje controlKilometraje) async {
    print(controlKilometraje.idVehiculo);
    await TraerToken().mostrarDatos();

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/controlkilometraje/rest/crear'),
        body: '{'
            '"vehiculo":"${controlKilometraje.idVehiculo}",'
            '"hora_salida" : "${controlKilometraje.horaSalida}",'
            '"hora_llegada" : "${controlKilometraje.horaLlegada}",'
            '"kilometraje_salida" : "${controlKilometraje.kilometrajeSalida}",'
            '"kilometraje_llegada" : "${controlKilometraje.kilometrajeLlegada}",'
            '"kilometro_recorrido" : "${controlKilometraje.kilometroRecorrido}"'
            '}',
        headers: TraerToken.headers);
    print('{'
        '"vehiculo":"${controlKilometraje.idVehiculo}",'
        '"hora_salida" : "${controlKilometraje.horaSalida}",'
        '"hora_llegada" : "${controlKilometraje.horaLlegada}",'
        '"kilometraje_salida" : "${controlKilometraje.kilometrajeSalida}",'
        '"kilometraje_llegada" : "${controlKilometraje.kilometrajeLlegada}",'
        '"kilometro_recorrido" : "${controlKilometraje.kilometroRecorrido}"'
        '}');
    print(response.body);
    if (response.statusCode == 200) {
      return response.statusCode.toString();
    } else if (response.statusCode == 400) {
      return response.statusCode.toString();
    }
    return response.statusCode.toString();
  }
}
