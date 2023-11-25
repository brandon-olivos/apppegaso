class ListaAsignaciones {
  List<ListaAsignacion> items = [];
  ListaAsignaciones();
  ListaAsignaciones.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new ListaAsignacion.fromJson(item);
      items.add(_listarTrabajador);
    }
  }
}

class ListaAsignacion {
  String id;
  String contacto;
  String entidad;
  String solicitud;
  String fecha;
  String telefono;
  String hora;
  String destinatario;
  String id_destinatario;
  String direccion_llegada;
  String id_direccion_destino;

  ListaAsignacion({
    this.id = '',
    this.contacto = '',
    this.entidad = '',
    this.solicitud = '',
    this.fecha = '',
    this.telefono = '',
    this.hora = '',
    this.destinatario = '',
    this.id_destinatario = '',
    this.direccion_llegada = '',
    this.id_direccion_destino = '',
  });

  factory ListaAsignacion.fromMap(Map<String, dynamic> obj) => ListaAsignacion(
        id: obj['id_atencion_pedidos'],
        contacto: obj['contacto'],
        entidad: obj['razon_social'],
        solicitud: obj['nm_solicitud'],
        fecha: obj['fecha'],
        telefono: obj['telefono'],
        hora: obj['hora_recojo'],
        destinatario: obj['destinatario'],
        id_destinatario: obj['id_destinatario'],
        direccion_llegada: obj['direccion_llegada'],
        id_direccion_destino: obj['id_direccion_destino'],
      );

  factory ListaAsignacion.fromJson(Map<String, dynamic> obj) {
    return ListaAsignacion(
      id: obj['id_atencion_pedidos'],
      contacto: obj['contacto'],
      entidad: obj['razon_social'],
      solicitud: obj['nm_solicitud'],
      fecha: obj['fecha'],
      telefono: obj['telefono'],
      hora: obj['hora_recojo'],
      destinatario: obj['destinatario'],
      id_destinatario: obj['id_destinatario'],
      direccion_llegada: obj['direccion_llegada'],
      id_direccion_destino: obj['id_direccion_destino'],
    );
  }
}
