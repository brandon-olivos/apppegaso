class DetalleRenCuenModels {
  List<DetalleRenCuenModel> items = [];
  DetalleRenCuenModels();
  DetalleRenCuenModels.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarAsistenciaActual = new DetalleRenCuenModel.fromJson(item);
      items.add(_listarAsistenciaActual);
    }
  }
}

class DetalleRenCuenModel {
  int id;
  String fecha;
  int idTipoComprobante;
  String proveedor;
  String ndocumento;
  String concepto;
  double monto;

  DetalleRenCuenModel(
      {this.id = 0,
      this.fecha,
      this.idTipoComprobante = 0,
      this.proveedor,
      this.ndocumento,
      this.concepto,
      this.monto});

  DetalleRenCuenModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    fecha = map['fecha'];
    idTipoComprobante = map['id_tipo_comprobante'];
    proveedor = map['proveedor'];
    ndocumento = map['ndocumento'];
    concepto = map['concepto'];
    monto = map['monto'];
  }
  factory DetalleRenCuenModel.fromJson(Map<String, dynamic> parsedJson) {
    return DetalleRenCuenModel(
      fecha: parsedJson['fecha'],
      idTipoComprobante: parsedJson['id_tipo_comprobante'],
      proveedor: parsedJson['proveedor'],
      ndocumento: parsedJson['ndocumento'],
      concepto: parsedJson['concepto'],
      monto: parsedJson['monto'],
    );
  }
  DetalleRenCuenModel.map(dynamic obj) {
    fecha = obj['fecha'];
    idTipoComprobante = obj['id_tipo_comprobante'];
    proveedor = obj['proveedor'];
    ndocumento = obj['ndocumento'];
    concepto = obj['concepto'];
    monto = obj['monto'];
  }

  String get getfecha => fecha;
  String get getproveedor => proveedor;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["fecha"] = fecha;
    map["id_tipo_comprobante"] = idTipoComprobante;
    map["proveedor"] = proveedor;
    map["ndocumento"] = ndocumento;
    map["concepto"] = concepto;
    map["monto"] = monto;
    return map;
  }
}

DetalleRenCuenModel detalleRenMode;
