class Transportista {
  Transportista({
    this.idTransportista='',
    this.documento='',
    this.numeroDocumento='',
    this.razonSocial='',
    this.telefono='',
    this.correo='',
    this.direccion='',
    this.nombreDistrito='',
    this.total='',
  });

  String idTransportista;
  String documento;
  String numeroDocumento;
  String razonSocial;
  String telefono;
  String correo;
  String direccion;
  String nombreDistrito;
  String total;

  factory Transportista.fromJson(Map<String, dynamic> json) => Transportista(
    idTransportista: json["id_transportista"],
    documento: json["documento"],
    numeroDocumento: json["numero_documento"],
    razonSocial: json["razon_social"],
    telefono: json["telefono"],
    correo:  json["correo"],
    direccion: json["direccion"],
    nombreDistrito: json["nombre_distrito"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() =>
      {
        "id_transportista": idTransportista,
        "documento": documento,
        "numero_documento": numeroDocumento,
        "razon_social": razonSocial,
        "telefono": telefono,
        "correo": correo,
        "direccion": direccion,
        "nombre_distrito": nombreDistrito,
        "total": total,
      };
}
