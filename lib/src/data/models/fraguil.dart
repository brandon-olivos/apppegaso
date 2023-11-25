class Fragils {
  List<Fragil> items = [];
  Fragils();

  Fragils.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTipoUnidad = new Fragil.fromJson(item);
      items.add(_listarTipoUnidad);
    }
  }
}

class Fragil {
  int id;
  String valor;
 
  Fragil({
    this.id = 0,
    this.valor = '',
 
  });

  factory Fragil.fromMap(Map<String, dynamic> obj) => Fragil(
        id: obj['id'],
        valor: obj['valor'],
        
      );

  factory Fragil.fromJson(Map<String, dynamic> obj) {
    return Fragil(
      id: obj['id'],
      valor: obj['valor'],
     
    );
  }
}
