class Vias {
  List<Via> items = [];
  Vias();

  Vias.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarVia = new Via.fromJson(item);
      items.add(_listarVia);
    }
  }
}

class Via {
  int idVia;
  String nombreVia;

  Via({
    this.idVia = 0,
    this.nombreVia = '',
  });

  factory Via.fromMap(Map<String, dynamic> obj) => Via(
        idVia: obj['id_via'],
        nombreVia: obj['nombre_via'],
      );

  factory Via.fromJson(Map<String, dynamic> obj) {
    return Via(
      idVia: obj['id_via'],
      nombreVia: obj['nombre_via'],
    );
  }
}
