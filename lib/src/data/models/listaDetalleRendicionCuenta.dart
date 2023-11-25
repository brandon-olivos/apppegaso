import 'package:Pegaso/src/data/models/detalleRendicionCuentas.dart';

class ListaDetalleRendicionCuentaes {
  List<ListaDetalleRendicionCuenta> items = [];
  ListaDetalleRendicionCuentaes();
  ListaDetalleRendicionCuentaes.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final _listarTrabajador = new ListaDetalleRendicionCuenta.fromJson(item);
      items.add(_listarTrabajador);
    }
  }
}

class ListaDetalleRendicionCuenta {
  String idDetalleRendicionCuentas;
  String idRendicionCuentas;
  String diferenciaDepositarReembolsar;
  int idTipoComprobante;
  String fecha;
  String tipoComprobante;
  String proveedor;
  String nmDocumento;
  String concepto;
  String monto;
  String total;

  ListaDetalleRendicionCuenta({
    this.idDetalleRendicionCuentas = "",
    this.diferenciaDepositarReembolsar = '',
    this.idRendicionCuentas = "",
    this.idTipoComprobante = 0,
    this.tipoComprobante = "",
    this.fecha = "",
    this.proveedor = "",
    this.nmDocumento = "",
    this.concepto = "",
    this.monto = "",
    this.total = "",
    //  required this.detalleRemisionCuenta,
  });
  factory ListaDetalleRendicionCuenta.fromJson(Map<String, dynamic> json) {
    return ListaDetalleRendicionCuenta(
      idDetalleRendicionCuentas: json["id_detalle_rendicion_cuentas"],
      diferenciaDepositarReembolsar: json["diferencia_depositar_reembolsar"],
      idRendicionCuentas: json["id_rendicion_cuentas"],
      idTipoComprobante: int.parse(json["id_tipo_comprobante"]),
      tipoComprobante: json["tipo_comprobante"],
      fecha: json["fecha"],
      proveedor: json["proveedor"],
      nmDocumento: json["nm_documento"],
      concepto: json["concepto"],
      monto: json["monto"],
      total: json["total"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id_detalle_rendicion_cuentas": idDetalleRendicionCuentas,
        "diferencia_depositar_reembolsar": diferenciaDepositarReembolsar,
        "id_rendicion_cuentas": idRendicionCuentas,
        "id_tipo_comprobante": idTipoComprobante,
        "tipo_comprobante": tipoComprobante,
        "fecha": fecha,
        "proveedor": proveedor,
        "nm_documento": nmDocumento,
        "concepto": concepto,
        "monto": monto,
        "total": total,
      };
}
