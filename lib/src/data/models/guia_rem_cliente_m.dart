class ListaGuiaRemClienteM {
  List<GuiaRemClienteM> items = [];

  ListaGuiaRemClienteM();

  ListaGuiaRemClienteM.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new GuiaRemClienteM.fromJson(item);
      items.add(_listarTrabajador);
    }
  }
}

class GuiaRemClienteM {
  int id;
  int idGuiaRemisionCliente;
  int idTemporalTablaGr;

  //int idGuiaRemision;
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
  String tipoCarga;
  String descripcion;

  GuiaRemClienteM(
      {this.id = 0,
      this.idGuiaRemisionCliente = 0,
      this.idTemporalTablaGr = 0,
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
      this.tipoCarga = '',
      this.descripcion = ''});

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id_guia_remision_cliente"] = idGuiaRemisionCliente;
    map["id_temporal_tabla_gr"] = idTemporalTablaGr;
    map["grs"] = grs;
    map["gr"] = gr;
    map["delivery"] = delivery;
    map["oc"] = oc;
    map["cantidad"] = cantidad;
    map["peso"] = peso;
    map["volumen"] = volumen;
    map["alto"] = alto;
    map["ancho"] = ancho;
    map["largo"] = largo;
    map["id_tipo_carga"] = idTipoCarga;
    map["tipo_carga"] = tipoCarga;
    map["descripcion"] = descripcion;
    map["ft"] = ft;

    return map;
  }

  factory GuiaRemClienteM.fromMap(Map<String, dynamic> obj) => GuiaRemClienteM(
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
        tipoCarga: obj["tipo_carga"],
      );

  factory GuiaRemClienteM.fromJson(Map<String, dynamic> obj) {
    return GuiaRemClienteM(
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
      tipoCarga: obj["tipo_carga"],
    );
  }
}
