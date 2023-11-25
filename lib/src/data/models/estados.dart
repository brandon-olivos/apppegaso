class Estados2 {
  List<Estados> items = [];
  Estados2();

  Estados2.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarEstados = new Estados.fromJson(item);
      items.add(_listarEstados);
    }
  }
}

class Estados {
  int id_estado;
  int id_tipo_estado;
  String siglas;
  String nombre_estado;

  Estados({
    this.id_estado = 0,
    this.id_tipo_estado = 0,
    this.siglas = '',
    this.nombre_estado = '',
  });

  factory Estados.fromMap(Map<String, dynamic> obj) => Estados(
        id_estado: obj['id_estado'],
        id_tipo_estado: obj['id_tipo_estado'],
        siglas: obj['siglas'],
        nombre_estado: obj['nombre_estado'],
      );

  factory Estados.fromJson(Map<String, dynamic> obj) {
    return Estados(
      id_estado: int.parse(obj['id_estado']),
      id_tipo_estado: int.parse(obj['id_tipo_estado']),
      siglas: obj['siglas'],
      nombre_estado: obj['nombre_estado'],
    );
  }
}
