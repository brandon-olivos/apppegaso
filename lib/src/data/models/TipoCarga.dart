class TipoCargas {
  List<TipoCarga> items = [];
  TipoCargas();

  TipoCargas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTipoCarga = new TipoCarga.fromJson(item);
      items.add(_listarTipoCarga);
    }
  }
}

class TipoCarga {
  int idTipoCarga;
  String nombreTipoCarga;

  TipoCarga({
    this.idTipoCarga = 0,
    this.nombreTipoCarga = '',
  });

  factory TipoCarga.fromMap(Map<String, dynamic> obj) => TipoCarga(
        idTipoCarga: obj['id_tipo_carga'],
        nombreTipoCarga: obj['nombre'],
      );

  factory TipoCarga.fromJson(Map<String, dynamic> obj) {
    return TipoCarga(
      idTipoCarga: obj['id_tipo_carga'],
      nombreTipoCarga: obj['nombre'],
    );
  }
}
