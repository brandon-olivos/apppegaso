class GRClienteSeguimiento2 {
  List<GRClienteSeguimiento> items = [];
  GRClienteSeguimiento2();

  GRClienteSeguimiento2.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarEstados = new GRClienteSeguimiento.fromJson(item);
      items.add(_listarEstados);
    }
  }
}

class GRClienteSeguimiento {
  int id_guia_remision_cliente;
  int id_guia_remision;
  String grs;
  String guia_cliente;
  String gr;
  String ft;
  String delivery;
  String oc;
  int cantidad;
  String peso;
  String volumen;
  String alto;
  String largo;
  String ancho;
  int id_tipo_carga;
  String descripcion;
  int id_archivo;
  int id_estado_mercaderia;
  String estado_mercaderia;
  int id_estado_cargo;
  String estado_cargo;
  String recibido_por;
  String entregado_por;
  String observacion;
  String fecha_hora_entrega;
  String fecha_cargo;
  String hora_entrega;
  String tipo_carga;
  String nombre_ruta;

  GRClienteSeguimiento({
    this.id_guia_remision_cliente = 0,
    this.id_guia_remision = 0,
    this.guia_cliente = '',
    this.grs = '',
    this.gr = '',
    this.ft = '',
    this.delivery = '',
    this.oc = '',
    this.cantidad = 0,
    this.peso = '',
    this.volumen = '',
    this.alto = '',
    this.largo = '',
    this.ancho = '',
    this.id_tipo_carga = 0,
    this.descripcion = '',
    this.id_archivo = 0,
    this.id_estado_mercaderia = 0,
    this.estado_mercaderia = '',
    this.id_estado_cargo = 0,
    this.estado_cargo = '',
    this.recibido_por = '',
    this.entregado_por = '',
    this.observacion = '',
    this.fecha_hora_entrega = '',
    this.fecha_cargo = '',
    this.hora_entrega = '',
    this.tipo_carga = '',
    this.nombre_ruta = '',
  });

  factory GRClienteSeguimiento.fromMap(Map<String, dynamic> obj) =>
      GRClienteSeguimiento(
        id_guia_remision_cliente: obj['id_guia_remision_cliente'],
        id_guia_remision: obj['id_guia_remision'],
        guia_cliente: obj['guia_cliente'],
        grs: obj['grs'],
        gr: obj['gr'],
        ft: obj['ft'],
        delivery: obj['delivery'],
        oc: obj['oc'],
        cantidad: obj['cantidad'],
        peso: obj['peso'],
        volumen: obj['volumen'],
        alto: obj['alto'],
        largo: obj['largo'],
        ancho: obj['ancho'],
        id_tipo_carga: obj['id_tipo_carga'],
        descripcion: obj['descripcion'],
        id_archivo: obj['id_archivo'],
        id_estado_mercaderia: obj['id_estado_mercaderia'],
        estado_mercaderia: obj['estado_mercaderia'],
        id_estado_cargo: obj['id_estado_cargo'],
        estado_cargo: obj['estado_cargo'],
        recibido_por: obj['recibido_por'],
        entregado_por: obj['entregado_por'],
        observacion: obj['observacion'],
        fecha_hora_entrega: obj['fecha_hora_entrega'],
        fecha_cargo: obj['fecha_cargo'],
        hora_entrega: obj['hora_entrega'],
        tipo_carga: obj['tipo_carga'],
        nombre_ruta: obj['nombre_ruta'],
      );

  factory GRClienteSeguimiento.fromJson(Map<String, dynamic> obj) {
    return GRClienteSeguimiento(
      id_guia_remision_cliente: int.parse(obj['id_guia_remision_cliente']),
      id_guia_remision: int.parse(obj['id_guia_remision']),
      grs: obj['grs'],
      guia_cliente: obj['guia_cliente'],
      gr: obj['gr'],
      ft: obj['ft'],
      delivery: obj['delivery'],
      oc: obj['oc'],
      cantidad: int.parse(obj['cantidad']),
      peso: obj['peso'],
      volumen: obj['volumen'],
      alto: obj['alto'],
      largo: obj['largo'],
      ancho: obj['ancho'],
      id_tipo_carga: int.parse(obj['id_tipo_carga']),
      descripcion: obj['descripcion'],
      id_archivo: int.parse(obj['id_archivo']),
      id_estado_mercaderia: int.parse(obj['id_estado_mercaderia']),
      estado_mercaderia: obj['estado_mercaderia'],
      id_estado_cargo: int.parse(obj['id_estado_cargo']),
      estado_cargo: obj['estado_cargo'],
      recibido_por: obj['recibido_por'],
      entregado_por: obj['entregado_por'],
      observacion: obj['observacion'],
      fecha_hora_entrega: obj['fecha_hora_entrega'],
      fecha_cargo: obj['fecha_cargo'],
      hora_entrega: obj['hora_entrega'],
      tipo_carga: obj['tipo_carga'],
      nombre_ruta: obj['nombre_ruta'],
    );
  }
}
