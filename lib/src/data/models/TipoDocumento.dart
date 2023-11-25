class ListaTipoDocumento {
  List<TipoDocumento> items = [];
  ListaTipoDocumento();

  ListaTipoDocumento.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTipoUnidad = new TipoDocumento.fromJson(item);
      items.add(_listarTipoUnidad);
    }
  }
}

class TipoDocumento {
  int id_tipo_documento;
  String documento;

  TipoDocumento({
    this.id_tipo_documento = 0,
    this.documento = '',
  });

  factory TipoDocumento.fromMap(Map<String, dynamic> obj) => TipoDocumento(
        id_tipo_documento: obj['id_tipo_documento'],
        documento: obj['documento'],
      );

  factory TipoDocumento.fromJson(Map<String, dynamic> obj) {
    return TipoDocumento(
      id_tipo_documento: obj['id_tipo_documento'],
      documento: obj['documento'],
    );
  }
}
