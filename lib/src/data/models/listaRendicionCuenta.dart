class ListaRendicionCuentaes {
  List<ListaRendicionCuenta> items = [];
  ListaRendicionCuentaes();
  ListaRendicionCuentaes.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final _listarTrabajador = new ListaRendicionCuenta.fromJson(item);
      items.add(_listarTrabajador);
    }
  }
}

class ListaRendicionCuenta {
  String idRendicionCuentas;
  String fecha;
  String nrOperacion;
  String abonoCuentaDe;
  String rinde;
  String importeEntregado;
  String diferenciaDepositarReembolsar;
  String flgEstado;
  String totalGasto;
  // List<DetalleRemisionCuenta> detalleRemisionCuenta;

  ListaRendicionCuenta({
    this.diferenciaDepositarReembolsar = '',
    this.idRendicionCuentas = '',
    this.fecha = '',
    this.nrOperacion = '',
    this.abonoCuentaDe = '',
    this.rinde = '',
    this.importeEntregado = "",
    this.flgEstado = '',
    this.totalGasto = '',
    //  required this.detalleRemisionCuenta,
  });
  factory ListaRendicionCuenta.fromJson(Map<String, dynamic> json) {
    return ListaRendicionCuenta(
        idRendicionCuentas: json["id_rendicion_cuentas"],
        fecha: json["fecha"],
        nrOperacion: json["nr_operacion"],
        abonoCuentaDe: json["id_abono_cuenta_de"],
        rinde: json["rinde"],
        importeEntregado: json["importe_entregado"],
        diferenciaDepositarReembolsar: json["diferencia_depositar_reembolsar"],
        flgEstado: json["flg_estado"],
        totalGasto: json["total_gasto"]
/*        detalleRemisionCuenta: List<DetalleRemisionCuenta>.from(
            json["detalle_remision_cuenta"]
                .map((x) => DetalleRemisionCuenta.fromJson(x))),*/
        );
  }

  Map<String, dynamic> toJson() => {
        "id_rendicion_cuentas": idRendicionCuentas,
        "fecha": fecha,
        "nr_operacion": nrOperacion,
        "id_abono_cuenta_de": abonoCuentaDe,
        "rinde": rinde,
        "importe_entregado": importeEntregado,
        "diferencia_depositar_reembolsar": diferenciaDepositarReembolsar,
        "flg_estado": flgEstado,
        "total_gasto": totalGasto,
        /*   "detalle_remision_cuenta":
            List<dynamic>.from(detalleRemisionCuenta.map((x) => x.toJson())), */
      };
}
