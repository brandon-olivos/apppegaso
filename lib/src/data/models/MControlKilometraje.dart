class ListaControlKilometraje {
  List<MControlKilometraje> items = [];
  ListaControlKilometraje();
  ListaControlKilometraje.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final _listarTrabajador = new MControlKilometraje.fromJson(item);
      items.add(_listarTrabajador);
    }
  }
}

class MControlKilometraje {
  String idControlKilometraje;
  String idVehiculo;
  String horaSalida;
  String horaLlegada;
  String kilometrajeSalida;
  String kilometrajeLlegada;
  String kilometroRecorrido;
  String lugarDestino;
  String nombreVehiculo;

  MControlKilometraje(
      {this.idControlKilometraje = '',
      this.idVehiculo = '',
      this.horaSalida = '',
      this.horaLlegada = '',
      this.kilometrajeSalida = '',
      this.kilometrajeLlegada = '',
      this.kilometroRecorrido = '',
      this.lugarDestino = '',
      this.nombreVehiculo = ''});

  factory MControlKilometraje.fromJson(Map<String, dynamic> obj) {
    return MControlKilometraje(
        idControlKilometraje: obj['id_control_kilometraje'],
        idVehiculo: obj['id_vehiculo'],
        horaSalida: obj['hora_salida'],
        horaLlegada: obj['hora_llegada'],
        kilometrajeSalida: obj['kilometraje_salida'],
        kilometrajeLlegada: obj['kilometraje_llegada'],
        kilometroRecorrido: obj['kilometro_recorrido'],
        lugarDestino: obj['lugar_destino'],
        nombreVehiculo: obj['vehiculo']);
  }

  Map<String, dynamic> toJson() => {
        "id_control_kilometraje": idControlKilometraje,
        "id_vehiculo": idVehiculo,
        "hora_salida": horaSalida,
        "horaLlegada": horaLlegada,
        "kilometraje_salida": kilometrajeSalida,
        "kilometraje_llegada": kilometrajeLlegada,
        "kilometro_recorrido": kilometroRecorrido,
        "lugar_destino": lugarDestino
      };
}
