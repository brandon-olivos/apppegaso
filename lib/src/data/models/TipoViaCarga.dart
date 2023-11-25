class TipoViaCargas {
  List<TipoViaCarga> items = [];
  TipoViaCargas();

  TipoViaCargas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarVia = new TipoViaCarga.fromJson(item);
      items.add(_listarVia);
    }
  }
}

class TipoViaCarga {
  int id_tipo_via_carga;
  int id_via;
  String tipo_via_carga;

  TipoViaCarga(
      {this.id_tipo_via_carga = 0, this.id_via = 0, this.tipo_via_carga = ''});

  factory TipoViaCarga.fromMap(Map<String, dynamic> obj) => TipoViaCarga(
      id_tipo_via_carga: obj['id_tipo_via_carga'],
      id_via: obj['nombre_via'],
      tipo_via_carga: obj['tipo_via_carga']);

  factory TipoViaCarga.fromJson(Map<String, dynamic> obj) {
    return TipoViaCarga(
        id_tipo_via_carga: obj['id_tipo_via_carga'],
        id_via: obj['id_via'],
        tipo_via_carga: obj['tipo_via_carga']);
  }
}
