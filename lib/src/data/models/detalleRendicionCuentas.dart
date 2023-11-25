class DetalleRemisionCuenta {
  DetalleRemisionCuenta({
    this.fecha = '',
    this.proveedor = '',
    this.nmDocumento = '',
    this.concepto = '',
    this.monto = 0.0,
    this.flgEstado = 0,
  });

  String fecha;
  String proveedor;
  String nmDocumento;
  String concepto;
  double monto;
  int flgEstado;

  factory DetalleRemisionCuenta.fromJson(Map<String, dynamic> json) =>
      DetalleRemisionCuenta(
        fecha: json["fecha"],
        proveedor: json["proveedor"],
        nmDocumento: json["nm_documento"],
        concepto: json["concepto"],
        monto: json["monto"].toDouble(),
        flgEstado: json["flg_estado"],
      );

  Map<String, dynamic> toJson() => {
        "fecha": fecha,
        "proveedor": proveedor,
        "nm_documento": nmDocumento,
        "concepto": concepto,
        "monto": monto,
        "flg_estado": flgEstado,
      };
}
