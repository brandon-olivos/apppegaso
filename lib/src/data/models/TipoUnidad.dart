class TipoUnidads {
  List<TipoUnidad> items = [];
  TipoUnidads();

  TipoUnidads.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTipoUnidad = new TipoUnidad.fromJson(item);
      items.add(_listarTipoUnidad);
    }
  }
}

class TipoUnidad {
  int id_tipo_unidad;
  String descripcion;

  TipoUnidad({
    this.id_tipo_unidad = 0,
    this.descripcion = '',
  });

  factory TipoUnidad.fromMap(Map<String, dynamic> obj) => TipoUnidad(
        id_tipo_unidad: obj['id_tipo_unidad'],
        descripcion: obj['descripcion'],
      );

  factory TipoUnidad.fromJson(Map<String, dynamic> obj) {
    return TipoUnidad(
      id_tipo_unidad: obj['id_tipo_unidad'],
      descripcion: obj['descripcion'],
    );
  }
}
