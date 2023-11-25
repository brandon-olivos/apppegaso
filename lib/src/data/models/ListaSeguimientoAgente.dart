class ListaSeguimientoAgentes {
  List<ListaSeguimientoAgente> items = [];
  ListaSeguimientoAgentes();
  ListaSeguimientoAgentes.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new ListaSeguimientoAgente.fromJson(item);
      items.add(_listarTrabajador);
    }
  }
}

class ListaSeguimientoAgente {
  String id_guia_remision;
  String numero_guia;
  String cuenta;
  String usuario;
  String direccion;
  String nombre_provincia;
  String fecha_traslado;
  String nombre_estado;
  String tipo;

  ListaSeguimientoAgente(
      {this.id_guia_remision = '',
      this.numero_guia = '',
      this.cuenta = '',
      this.usuario = '',
      this.direccion = '',
      this.nombre_provincia = '',
      this.fecha_traslado = '',
      this.nombre_estado = '',
      this.tipo = ''});

  factory ListaSeguimientoAgente.fromMap(Map<String, dynamic> obj) =>
      ListaSeguimientoAgente(
          id_guia_remision: obj['id_guia_remision'],
          numero_guia: obj['numero_guia'],
          cuenta: obj['cuenta'],
          usuario: obj['usuario'],
          direccion: obj['direccion'],
          nombre_provincia: obj['nombre_provincia'],
          fecha_traslado: obj['fecha_traslado'],
          nombre_estado: obj['nombre_estado'],
          tipo: obj['tipo']);

  factory ListaSeguimientoAgente.fromJson(Map<String, dynamic> obj) {
    return ListaSeguimientoAgente(
        id_guia_remision: obj['id_guia_remision'],
        numero_guia: obj['numero_guia'],
        cuenta: obj['cuenta'],
        usuario: obj['usuario'],
        direccion: obj['direccion'],
        nombre_provincia: obj['nombre_provincia'],
        fecha_traslado: obj['fecha_traslado'],
        nombre_estado: obj['nombre_estado'],
        tipo: obj['tipo']);
  }
}
