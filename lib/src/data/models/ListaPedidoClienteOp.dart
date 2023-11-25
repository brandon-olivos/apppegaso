// ignore: camel_case_types
class ListaPedidoClienteOps {
  List<ListaPedidoClienteOp> items = [];
  ListaPedidoClienteOps();
  ListaPedidoClienteOps.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new ListaPedidoClienteOp.fromJson(item);
      items.add(_listarTrabajador);
    }
  }
}

// ignore: camel_case_types
class ListaPedidoClienteOp {
  String id_atencion_pedidos;
  String nm_solicitud;
  String fecha;
  String hora_recojo;
  String id_tipo_servicios;
  String tipo_servicios;
  String nombre_estado;
  String cliente;
  String id_cliente;
  String id_pedido_cliente;
  String id_remitente;
  String id_destinatario;
  String id_tipo_unidad;
  String stoka;
  String estado_mercaderia;
  String fragil;
  String email;
  String cantidad;
  String peso;
  String alto;
  String ancho;
  String largo;
  String volumen;
  String fecha_entrega;
  String hora_entrega;
  String id_distrito;
  String id_direccion_recojo;
  String direccion_recojo;
  String id_direccion_destino;
  String contacto;
  String id_area;
  String area;
  String referencia;
  String telefono;
  String cantidad_personal;
  String observacion;
  String notificacion;
  String notificacion_descarga;
  String id_conductor;
  String conductor;
  String idAuxiliar;
  String auxiliar;
  String idUnidad;

  String nombre_area;
  String vehiculo;
  String remitente;

  String tipo_unidad;

  ListaPedidoClienteOp({
    this.id_atencion_pedidos = '',
    this.nm_solicitud = '',
    this.fecha = '',
    this.hora_recojo = '',
    this.id_tipo_servicios,
    this.tipo_servicios = '',
    this.nombre_estado = '',
    this.cliente = '',
    this.id_pedido_cliente = '',
    this.id_cliente = '',
    this.id_remitente = '',
    this.id_destinatario = '',
    this.id_tipo_unidad = '',
    this.stoka = '',
    this.estado_mercaderia = '',
    this.fragil = '',
    this.email = '',
    this.cantidad = '',
    this.peso = '',
    this.alto = '',
    this.ancho = '',
    this.largo = '',
    this.volumen = '',
    this.fecha_entrega = '',
    this.hora_entrega = '',
    this.id_distrito = '',
    this.id_direccion_recojo = '',
    this.direccion_recojo = '',
    this.id_direccion_destino = '',
    this.contacto = '',
    this.id_area = '',
    this.referencia = '',
    this.telefono = '',
    this.cantidad_personal = '',
    this.observacion = '',
    this.notificacion = '',
    this.notificacion_descarga = '',
    this.id_conductor = '',
    this.conductor = '',
    this.idAuxiliar = '',
    this.auxiliar = '',
    this.idUnidad = '',
    this.vehiculo = '',
    this.nombre_area = '',
    this.remitente = '',
    this.tipo_unidad = '',
  });

  factory ListaPedidoClienteOp.fromMap(Map<String, dynamic> obj) =>
      ListaPedidoClienteOp(
          id_atencion_pedidos: obj['id_atencion_pedidos'],
          nm_solicitud: obj['nm_solicitud'],
          fecha: obj['fecha'],
          hora_recojo: obj['hora_recojo'],
          id_tipo_servicios: obj['tipo_servicio'],
          tipo_servicios: obj['tipo_servicios'],
          nombre_estado: obj['nombre_estado'],
          cliente: obj['cliente'],
          id_pedido_cliente: obj['id_pedido_cliente'],
          id_remitente: obj['id_remitente'],
          id_destinatario: obj['id_destinatario'],
          id_tipo_unidad: obj['id_tipo_unidad'],
          stoka: obj['stoka'],
          estado_mercaderia: obj['estado_mercaderia'],
          fragil: obj['fragil'],
          email: obj['email'],
          cantidad: obj['cantidad'],
          peso: obj['peso'],
          alto: obj['alto'],
          ancho: obj['ancho'],
          largo: obj['largo'],
          volumen: obj['volumen'],
          fecha_entrega: obj['fecha_entrega'],
          hora_entrega: obj['hora_entrega'],
          id_distrito: obj['id_distrito'],
          id_direccion_recojo: obj['id_direccion_recojo'],
          direccion_recojo: obj['direccion_recojo'],
          id_direccion_destino: obj['id_direccion_destino'],
          contacto: obj['contacto'],
          id_area: obj['id_area'],
          referencia: obj['referencia'],
          telefono: obj['telefono'],
          cantidad_personal: obj['cantidad_personal'],
          observacion: obj['observacion'],
          notificacion: obj['notificacion'],
          notificacion_descarga: obj['notificacion_descarga'],
          id_conductor: obj['id_conductor'],
          conductor: obj['conductor'],
          idAuxiliar: obj['idAuxiliar'],
          auxiliar: obj['auxiliar'],
          idUnidad: obj['idUnidad'],
          vehiculo: obj['vehiculo'],
          id_cliente: obj['id_cliente'],
          nombre_area: obj['nombre_area'],
          remitente: obj['remitente'],
          tipo_unidad: obj['tipo_unidad']);

  factory ListaPedidoClienteOp.fromJson(Map<String, dynamic> obj) {
    return ListaPedidoClienteOp(
        id_atencion_pedidos: obj['id_atencion_pedidos'],
        nm_solicitud: obj['nm_solicitud'],
        fecha: obj['fecha'],
        hora_recojo: obj['hora_recojo'],
        id_tipo_servicios: obj['tipo_servicio'],
        tipo_servicios: obj['tipo_servicios'],
        nombre_estado: obj['nombre_estado'],
        cliente: obj['cliente'],
        id_pedido_cliente: obj['id_pedido_cliente'],
        id_remitente: obj['id_remitente'],
        id_destinatario: obj['id_destinatario'],
        id_tipo_unidad: obj['id_tipo_unidad'],
        stoka: obj['stoka'],
        estado_mercaderia: obj['estado_mercaderia'],
        fragil: obj['fragil'],
        email: obj['email'],
        cantidad: obj['cantidad'],
        peso: obj['peso'],
        alto: obj['alto'],
        ancho: obj['ancho'],
        largo: obj['largo'],
        volumen: obj['volumen'],
        fecha_entrega: obj['fecha_entrega'],
        hora_entrega: obj['hora_entrega'],
        id_distrito: obj['id_distrito'],
        id_direccion_recojo: obj['id_direccion_recojo'],
        direccion_recojo: obj['direccion_recojo'],
        id_direccion_destino: obj['id_direccion_destino'],
        contacto: obj['contacto'],
        id_area: obj['id_area'],
        referencia: obj['referencia'],
        telefono: obj['telefono'],
        cantidad_personal: obj['cantidad_personal'],
        observacion: obj['observacion'],
        notificacion: obj['notificacion'],
        notificacion_descarga: obj['notificacion_descarga'],
        id_conductor: obj['id_conductor'],
        conductor: obj['conductor'],
        idAuxiliar: obj['idAuxiliar'],
        auxiliar: obj['auxiliar'],
        idUnidad: obj['idUnidad'],
        vehiculo: obj['vehiculo'],
        id_cliente: obj['id_cliente'],
        nombre_area: obj['nombre_area'],
        remitente: obj['remitente'],
        tipo_unidad: obj['tipo_unidad']);
  }
}
