class ListaGuiasClientes {
  List<GuiaCliente> items = [];
  ListaGuiasClientes();
  ListaGuiasClientes.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new GuiaCliente.fromJson(item);
      items.add(_listarTrabajador);
    }
  }
}

class GuiaCliente {
  int id;
  String idGuiaRemisionCliente;
  int idTemporalTablaGr;
  String idGuiaRemision;
  String grs;
  String gr;
  String ft;
  String delivery;
  String oc;
  String cantidad;
  String peso;
  String volumen;
  String alto;
  String largo;
  String ancho;
  String idTipoCarga;
  String descripcion;
  String tipo_carga;
  String guia_cliente;

  GuiaCliente(
      {this.id = 0,
      this.idGuiaRemisionCliente = '',
      this.idTemporalTablaGr = 0,
      this.idGuiaRemision = '',
      this.grs = '',
      this.gr = '',
      this.ft = '',
      this.delivery = '',
      this.oc = '',
      this.cantidad = '',
      this.peso = '',
      this.volumen = '',
      this.alto = '',
      this.ancho = '',
      this.largo = '',
      this.idTipoCarga = '',
      this.descripcion = '',
      this.tipo_carga = '',
      this.guia_cliente = ''});

  factory GuiaCliente.fromMap(Map<String, dynamic> obj) => GuiaCliente(
        id: obj['id'],
        idGuiaRemisionCliente: obj['idGuiaRemisionCliente'],
        idTemporalTablaGr: obj['idTemporalTablaGr'],
        grs: obj['grs'],
        gr: obj['gr'],
        ft: obj['ft'],
        delivery: obj['delivery'],
        oc: obj['oc'],
        cantidad: obj['cantidad'],
        peso: obj['peso'],
        volumen: obj['volumen'],
        alto: obj['alto'],
        ancho: obj['ancho'],
        largo: obj['largo'],
        idTipoCarga: obj['idTipoCarga'],
        descripcion: obj['descripcion'],
      );

  factory GuiaCliente.fromJson(Map<String, dynamic> obj) {
    return GuiaCliente(
      id: obj['id'],
      idGuiaRemisionCliente: obj['id_guia_remision_cliente'],
      idTemporalTablaGr: obj['idTemporalTablaGr'],
      idGuiaRemision: obj['id_guia_remision'],
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
      ancho: obj['ancho'],
      largo: obj['largo'],
      idTipoCarga: obj['id_tipo_carga'],
      tipo_carga: obj['tipo_carga'],
      descripcion: obj['descripcion'],
    );
  }
}
