class ListaDireccioness {
  List<ListaDirecciones> items = [];
  ListaDireccioness();
  ListaDireccioness.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new ListaDirecciones.fromJson(item);

      items.add(_listarTrabajador);
    }
  }
}

class ListaDirecciones {
  String idDireccion;
  String direccion;
  String idEntidad;
  String idUbigeo;
  String entidad;
  String urbanizacion;
  String referencia;
  String nombreProvincia;
  String nombreDistrito;
  ListaDirecciones(
      {this.idDireccion = '',
      this.direccion = '',
      this.entidad = '',
      this.nombreProvincia = '',
      this.nombreDistrito = '',
      this.idUbigeo,
      this.urbanizacion = '',
      this.referencia = '',
      this.idEntidad = ''});
  factory ListaDirecciones.fromJson(Map<String, dynamic> obj) {
    return ListaDirecciones(
        idDireccion: obj['id_direccion'],
        direccion: obj['direccion'],
        entidad: obj['razon_social'],
        nombreProvincia: obj['nombre_provincia'],
        nombreDistrito: obj['nombre_distrito'],
        idUbigeo: obj['id_ubigeo'],
        urbanizacion: obj['urbanizacion'],
        referencia: obj['referencias'],
        idEntidad: obj['id_entidad']);
  }
}
