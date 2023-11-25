class TipoComprobantes {
  List<TipoComprobante> items = [];
  TipoComprobantes();

  TipoComprobantes.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTipoComprobante = new TipoComprobante.fromJson(item);
      items.add(_listarTipoComprobante);
    }
  }
}

class TipoComprobante {
  int idTipoComprobante;
  String descripcion;

  TipoComprobante({
    this.idTipoComprobante = 0,
    this.descripcion = '',
  });

  factory TipoComprobante.fromMap(Map<String, dynamic> obj) => TipoComprobante(
        idTipoComprobante: obj['id_tipo_comprobante'],
        descripcion: obj['descripcion'],
      );

  factory TipoComprobante.fromJson(Map<String, dynamic> obj) {
    return TipoComprobante(
      idTipoComprobante: int.parse(obj['id_tipo_comprobante']),
      descripcion: obj['descripcion'],
    );
  }
}
