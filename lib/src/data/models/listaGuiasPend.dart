class ListaGuiasPends {
  List<ListaGuiasPend> items = [];
  ListaGuiasPends();
  ListaGuiasPends.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new ListaGuiasPend.fromJson(item);

      items.add(_listarTrabajador);
    }
  }
}

class ListaGuiasPend {
  String idGuiaRemision;
  String nmSolicitud;
  String fecha;
  String fechaTraslado;
  String origen;
  String destino;
  String nombreEstado;
  String id_remitente;
  String remitente;
  String id_destinatario;
  String destinatario;
  String id_agente;
  String agente;
  String id_direccion_llegada;
  String direccion_llegada;
  String via;
  String idVia;
  String id_tipo_via;
  String tipo_via_carga;

  ListaGuiasPend(
      {this.idGuiaRemision = '',
      this.nmSolicitud = '',
      this.fecha = '',
      this.fechaTraslado = '',
      this.origen = '',
      this.destino = '',
      this.nombreEstado = '',
      this.id_remitente = '',
      this.remitente = '',
      this.id_destinatario = '',
      this.destinatario = '',
      this.id_agente = '',
      this.agente = '',
      this.direccion_llegada = '',
      this.via = '',
      this.idVia = '',
      this.id_tipo_via = '',
      this.tipo_via_carga = '',
      this.id_direccion_llegada = ''});

  factory ListaGuiasPend.fromMap(Map<String, dynamic> obj) => ListaGuiasPend(
        idGuiaRemision: obj['id_guia_remision'],
        nmSolicitud: obj['nm_solicitud'],
        fecha: obj['fecha'],
        fechaTraslado: obj['fecha_traslado'],
        origen: obj['origen'],
        destino: obj['destino'],
        nombreEstado: obj['nombre_estado'],
        id_remitente: obj['id_remitente'],
        remitente: obj['remitente'],
        id_destinatario: obj['id_destinatario'],
        destinatario: obj['destinatario'],
        agente: obj['agente'],
        id_agente: obj['id_agente'],
        id_direccion_llegada: obj['id_direccion_llegada'],
        direccion_llegada: obj['direccion_llegada'],
        via: obj['via'],
        idVia: obj['idVia'],
        id_tipo_via: obj['id_tipo_via'],
        tipo_via_carga: obj['tipo_via_carga'],
      );

  factory ListaGuiasPend.fromJson(Map<String, dynamic> obj) {
    return ListaGuiasPend(
      idGuiaRemision: obj['id_guia_remision'],
      nmSolicitud: obj['nm_solicitud'],
      fecha: obj['fecha'],
      fechaTraslado: obj['fecha_traslado'],
      origen: obj['origen'],
      destino: obj['destino'],
      nombreEstado: obj['nombre_estado'],
      id_remitente: obj['id_remitente'],
      remitente: obj['remitente'],
      id_destinatario: obj['id_destinatario'],
      destinatario: obj['destinatario'],
      agente: obj['agente'],
      id_agente: obj['id_agente'],
      id_direccion_llegada: obj['id_direccion_llegada'],
      direccion_llegada: obj['direccion_llegada'],
      via: obj['via'],
      idVia: obj['idVia'],
      id_tipo_via: obj['id_tipo_via'],
      tipo_via_carga: obj['tipo_via_carga'],
    );
  }
}
