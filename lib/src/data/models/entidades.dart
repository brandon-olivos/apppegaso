class ListaEntidad {
  List<Entidad> items = [];
  ListaEntidad();
  ListaEntidad.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new Entidad.fromJsonE(item);
      items.add(_listarTrabajador);
    }
  }
}

class Entidad {
  String razon_social;
  int id_entidad;
  String numero_documento;
  String correo;
  String telefono;
  int id_tipo_documento;
  Entidad(
      {this.razon_social = '',
      this.id_entidad = 0,
      this.numero_documento = '',
      this.correo = '',
      this.telefono = '',
      this.id_tipo_documento = 0});

  static Entidad fromJson(Map<String, dynamic> json) => Entidad(
        razon_social: json['razon_social'] + ' ' + json['numero_documento'],
        id_entidad: json['id_entidad'],
        numero_documento: json['numero_documento'],
        correo: json['correo'],
        telefono: json['telefono'],
        id_tipo_documento: json['id_tipo_documento'],
      );

  static Entidad fromJsonLis(Map<String, dynamic> json) => Entidad(
        razon_social: json['razon_social'],
        id_entidad: json['id_entidad'],
        numero_documento: json['numero_documento'],
        correo: json['correo'],
        telefono: json['telefono'],
        id_tipo_documento: json['id_tipo_documento'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['razon_social'] = this.razon_social;
    data['id_entidad'] = this.id_entidad;
    data['numero_documento'] = this.numero_documento;
    data['correo'] = this.correo;
    data['telefono'] = this.telefono;
    data['id_tipo_documento'] = this.id_tipo_documento;
    return data;
  }

  factory Entidad.fromJsonE(Map<String, dynamic> obj) {
    return Entidad(
        razon_social: obj['razon_social'],
        correo: obj['correo'],
        numero_documento: obj['numero_documento'],
        telefono: obj['telefono'],
        id_entidad: int.parse(obj['id_entidad']),
        id_tipo_documento: int.parse(obj['id_tipo_documento']));
  }
}
