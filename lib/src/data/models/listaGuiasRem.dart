import 'dart:convert';

class ListaGuiasRem2 {
  List<ListaGuiasRem> items = [];
  ListaGuiasRem2();
  ListaGuiasRem2.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new ListaGuiasRem.fromJson(item);
      items.add(_listarTrabajador);
    }
  }
}

List<ListaGuiasRem> listaSeguimientoNuevosFromJson(String str) =>
    List<ListaGuiasRem>.from(
        json.decode(str).map((x) => ListaGuiasRem.fromJson(x)));

String listaSeguimientoNuevosToJson(List<ListaGuiasRem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListaGuiasRem {
  ListaGuiasRem(
      {this.idGuiaRemision = '',
      this.nmSolicitud = '',
      this.numero_guia = '',
      this.fecha = '',
      this.fechaTraslado = '',
      this.origen = '',
      this.destino = '',
      this.nombreEstado = '',
      this.remitente = '',
      this.destinatario = '',
      this.id_cliente = '',
      this.cliente = '',
      this.sunat_description = '',
      this.numero = '',
      this.serie = ''});

  String idGuiaRemision;
  String nmSolicitud;
  String numero_guia;
  String fecha;
  String fechaTraslado;
  String origen;
  String destino;
  String nombreEstado;
  String remitente;
  String destinatario;
  String id_cliente;
  String cliente;

  String sunat_description;
  String numero;
  String serie;

  factory ListaGuiasRem.fromJson(Map<String, dynamic> json) => ListaGuiasRem(
        idGuiaRemision: json['id_guia_remision'],
        nmSolicitud: json['nm_solicitud'],
        numero_guia: json['numero_guia'],
        fecha: json['fecha'],
        fechaTraslado: json['fecha_traslado'],
        origen: json['origen'],
        destino: json['destino'],
        nombreEstado: json['nombre_estado'],
        remitente: json['remitente'],
        destinatario: json['destinatario'],
        id_cliente: json['id_cliente'],
        cliente: json['cliente'],
        sunat_description: json['sunat_description'],
        numero: json['numero'],
        serie: json['serie'],
      );

  Map<String, dynamic> toJson() => {
        'id_guia_remision': idGuiaRemision,
        'nm_solicitud': nmSolicitud,
        'numero_guia': numero_guia,
        'fecha': fecha,
        'fecha_traslado': fechaTraslado,
        'origen': origen,
        'destino': destino,
        'nombre_estado': nombreEstado,
        'remitente': remitente,
        'destinatario': destinatario,
        'id_cliente': id_cliente,
        'cliente': cliente,
        'numero': numero,
        'serie': serie,
        'sunat_description': sunat_description,
      };
}
