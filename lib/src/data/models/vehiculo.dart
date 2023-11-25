
class Vehiculo {
  Vehiculo({
    this.idVehiculo='',
    this.idMarca='',
    this.nombreMarca='',
    this.placa='',
    this.descripcion='',
    this.incripcion='',
  });

  String idVehiculo;
  String idMarca;
  String nombreMarca;
  String placa;
  String descripcion;
  String incripcion;

  factory Vehiculo.fromJson(Map<String, dynamic> json) => Vehiculo(
    idVehiculo: json["id_vehiculo"],
    idMarca: json["id_marca"],
    nombreMarca: json["nombre_marca"],
    placa: json["placa"],
    descripcion: json["descripcion"],
    incripcion: json["incripcion"],
  );

  Map<String, dynamic> toJson() => {
    "id_vehiculo": idVehiculo,
    "id_marca": idMarca,
    "nombre_marca": nombreMarca,
    "placa": placa,
    "descripcion": descripcion,
    "incripcion": incripcion,
  };
}
