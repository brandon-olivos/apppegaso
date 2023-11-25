class Conductor {
  Conductor({
    this.idEmpleado='',
    this.empleado='',
  });

  String idEmpleado;
  String empleado;

  factory Conductor.fromJson(Map<String, dynamic> json) => Conductor(
    idEmpleado: json["id_empleado"],
    empleado: json["empleado"],
  );

  Map<String, dynamic> toJson() => {
    "id_empleado": idEmpleado,
    "empleado": empleado,
  };
}
