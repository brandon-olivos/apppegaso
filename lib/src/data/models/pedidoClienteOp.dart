// ignore: camel_case_types
class ListaDetallePedidos {
  List<PedidoClienteOp> items = [];
  ListaDetallePedidos();
  ListaDetallePedidos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new PedidoClienteOp.fromJson(item);
      items.add(_listarTrabajador);
    }
  }
}

// ignore: camel_case_types
class PedidoClienteOp {
  String idGuiaRemision;
  String nmSolicitud;
  String numeroGuia;
  String cliente;
  String correo;
  String remitente;
  String direccionEnvio;
  String direccionLlegada;
  String origen;
  String destino;
  String cantidad;
  String nombreVia;

  PedidoClienteOp(
      {this.idGuiaRemision = '',
      this.nmSolicitud = '',
      this.numeroGuia = '',
      this.cliente = '',
      this.correo = '',
      this.remitente = '',
      this.direccionEnvio = '',
      this.direccionLlegada = '',
      this.origen = '',
      this.destino = '',
      this.cantidad = '',
      this.nombreVia = ''});

  factory PedidoClienteOp.fromMap(Map<String, dynamic> obj) => PedidoClienteOp(
      idGuiaRemision: obj['id_guia_remision'],
      nmSolicitud: obj['nm_solicitud'],
      numeroGuia: obj['numero_guia'],
      cliente: obj['cliente'],
      correo: obj['correo'],
      remitente: obj['remitente'],
      direccionEnvio: obj['direccion_envio'],
      direccionLlegada: obj['direccion_llegada'],
      origen: obj['origen'],
      destino: obj['destino'],
      cantidad: obj['cantidad'],
      nombreVia: obj['nombre_via']);

  factory PedidoClienteOp.fromJson(Map<String, dynamic> obj) {
    return PedidoClienteOp(
        idGuiaRemision: obj['id_guia_remision'],
        nmSolicitud: obj['nm_solicitud'],
        numeroGuia: obj['numero_guia'],
        cliente: obj['cliente'],
        correo: obj['correo'],
        remitente: obj['remitente'],
        direccionEnvio: obj['direccion_envio'],
        direccionLlegada: obj['direccion_llegada'],
        origen: obj['origen'],
        destino: obj['destino'],
        cantidad: obj['cantidad'],
        nombreVia: obj['nombre_via']);
  }
}
