class ListaseguimientoAgRCs {
  List<ListaseguimientoAgRC> items = [];
  ListaseguimientoAgRCs();
  ListaseguimientoAgRCs.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new ListaseguimientoAgRC.fromJson(item);
      items.add(_listarTrabajador);
    }
  }
}

class ListaseguimientoAgRC {
  String id_guia_remision;
  String numero_guia;
  String descripcion;
  String fecha_reg;
  String tipo;
  String estado;
  String recibido_por;
  String nombre_ruta;
  String tipo_tabla;
  String observacion;

  ListaseguimientoAgRC(
      {this.id_guia_remision = '',
      this.numero_guia = '',
      this.descripcion = '',
      this.fecha_reg = '',
      this.tipo = '',
      this.estado = '',
      this.recibido_por = '',
      this.nombre_ruta = '',
      this.tipo_tabla = '',
      this.observacion = ''});

  factory ListaseguimientoAgRC.fromMap(Map<String, dynamic> obj) =>
      ListaseguimientoAgRC(
        id_guia_remision: obj['id'],
        numero_guia: obj['numero_guia'],
        descripcion: obj['descripcion'],
        fecha_reg: obj['fecha_reg'],
        tipo: obj['tipo'],
        tipo_tabla: obj['tipo_tabla'],
        estado: obj['estado'],
        recibido_por: obj['recibido_por'],
        nombre_ruta: obj['nombre_ruta'],
        observacion: obj['observacion'],
      );

  factory ListaseguimientoAgRC.fromJson(Map<String, dynamic> obj) {
    return ListaseguimientoAgRC(
      id_guia_remision: obj['id'],
      numero_guia: obj['numero_guia'],
      descripcion: obj['descripcion'],
      fecha_reg: obj['fecha_reg'],
      tipo: obj['tipo'],
      tipo_tabla: obj['tipo_tabla'],
      estado: obj['estado'],
      recibido_por: obj['recibido_por'],
      nombre_ruta: obj['nombre_ruta'],
      observacion: obj['observacion'],
    );
  }
}
