class PedidoCliente {
  // ignore: non_constant_identifier_names
  int id_remitente;
  int id_cliente;
  String nm_solicitud;
  String fecha;
  String hora_recojo;
  int tipo_servicio;
  int id_direccion_recojo;
  String contacto;
  int id_area;
  String referencia;
  String telefono;
  int cantidad_personal;

  int id_tipo_unidad;
  int stoka;
  int fragil;
  int cantidad;
  double peso;
  double alto;
  double ancho;
  double largo;
  int estado_mercaderia;
  String observacion;
  String notificacion;
  String notificacion_descarga;
  int auxiliar;
  int idConductor;
  int vehiculo;

  PedidoCliente({
    this.id_remitente = 0,
    this.id_cliente = 0,
    this.nm_solicitud = '',
    this.fecha = '',
    this.hora_recojo = '',
    this.tipo_servicio = 0,
    this.id_direccion_recojo = 0,
    this.contacto = '',
    this.id_area = 0,
    this.referencia = '',
    this.telefono = '',
    this.cantidad_personal = 0,
    this.id_tipo_unidad = 0,
    this.stoka = 0,
    this.fragil = 0,
    this.cantidad = 0,
    this.peso = 0,
    this.alto = 0,
    this.ancho = 0,
    this.largo = 0,
    this.estado_mercaderia = 0,
    this.observacion = '',
    this.notificacion = '',
    this.notificacion_descarga = '',
    this.idConductor,
    this.auxiliar,
    this.vehiculo,
  });
}
