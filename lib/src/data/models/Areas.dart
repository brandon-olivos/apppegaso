class Areass {
  List<Areas> items = [];
  Areass();

  Areass.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarAreas = new Areas.fromJson(item);
      items.add(_listarAreas);
    }
  }
}

class Areas {
  int id_area;
  String codigo_area;
  String nombre_area;

  Areas({
    this.id_area = 0,
    this.codigo_area = '',
    this.nombre_area = '',
  });

  factory Areas.fromMap(Map<String, dynamic> obj) => Areas(
        id_area: obj['id_area'],
        codigo_area: obj['codigo_area'],
        nombre_area: obj['nombre_area'],
      );

  factory Areas.fromJson(Map<String, dynamic> obj) {
    return Areas(
      id_area: obj['id_area'],
      codigo_area: obj['nombre_Areas'],
      nombre_area: obj['nombre_area'],
    );
  }
}
