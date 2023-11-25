class Auxiliars {
  List<Auxiliar> items = [];
  Auxiliars();

  Auxiliars.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarAreas = new Auxiliar.fromJson(item);

      items.add(_listarAreas);
    }
  }
}

class Auxiliar {
  String id_empleado;
  String empleado;

  Auxiliar({
    this.id_empleado = '',
    this.empleado = '',
  });

  factory Auxiliar.fromJson(Map<String, dynamic> obj) {
    return Auxiliar(
      id_empleado: obj['id_empleado'],
      empleado: obj['empleado'],
    );
  }
}
