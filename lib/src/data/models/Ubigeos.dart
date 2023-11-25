class ListaUbigeos {
  List<Ubigeos> items = [];
  ListaUbigeos();
  ListaUbigeos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new Ubigeos.fromJson(item);
      items.add(_listarTrabajador);
    }
  }
}

class Ubigeos {
  int idUbigeo;
  String nombreDepartamento;
  String nombreProvincia;
  String nombreDistrito;

  Ubigeos({
    this.idUbigeo = 0,
    this.nombreDepartamento = '',
    this.nombreProvincia = '',
    this.nombreDistrito = '',
  });
  factory Ubigeos.fromJson(Map<String, dynamic> obj) {
    return Ubigeos(
      idUbigeo: obj['id_ubigeo'],
      nombreDepartamento: obj['nombre_departamento'],
      nombreProvincia: obj['nombre_provincia'],
      nombreDistrito: obj['nombre_distrito'] +
          ' ' +
          obj['nombre_provincia'] +
          ' ' +
          obj['nombre_departamento'],
    );
  }
}
