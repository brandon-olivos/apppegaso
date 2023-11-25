import 'dart:convert';

List<GuiaRemAux> guiaRemAuxFromJson(String str) =>
    List<GuiaRemAux>.from(json.decode(str).map((x) => GuiaRemAux.fromJson(x)));

String guiaRemAuxToJson(List<GuiaRemAux> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GuiaRemAux {
  GuiaRemAux({
    this.idGuiaRemision = '',
    this.nmSolicitud = '',
    this.fecha = '',
    this.fechaTraslado = '',
    this.serie = '',
    this.numeroGuia = '',
    this.idVia = '0',
    this.nombreVia = '',
    this.idTipoVia = '',
    this.tipoViaCarga = '',
    this.idAgente = '',
    this.agente = '',
    this.idRemitente = '',
    this.remitente = '',
    this.idDireccionPartida = '',
    this.direccionPartida = '',
    this.idDestinatario = '',
    this.destinatario = '',
    this.idDireccionLlegada = '',
    this.direccionLlegada = '',
    this.idConductor = '',
    this.conductor = '',
    this.idVehiculo = '',
    this.vehiculo = '',
    this.idTransportista = '',
    this.transportista = '',
    this.guiaRemisionTransportista = '',
    this.facturaTransportista = '',
    this.importeTransportista = '',
    this.comentarioTransportista = '',
    this.idEstado = '',
    this.nombreEstado = '',
    this.idCliente = '',
    this.cliente = '',
    this.origen = '',
    this.destino = '',
    this.usuario = '',
    this.idUsuarioReg = '',
    this.aceptada_por_sunat = '',
    //error
    this.sunat_description = '',
    this.sunat_note = '',
    this.sunat_responsecode = '',
    this.sunat_soap_error = '',
    //ok
    this.num_guia = '',
    this.serie_num = '',
    this.enlace_del_pdf = '',
    this.cadena_para_codigo_qr = '',
  });

  String idGuiaRemision;
  String nmSolicitud;
  String fecha;
  String fechaTraslado;
  String serie;
  String numeroGuia;
  String idVia;
  String nombreVia;
  String idTipoVia;
  String tipoViaCarga;
  String idAgente;
  String agente;
  String idRemitente;
  String remitente;
  String idDireccionPartida;
  String direccionPartida;
  String idDestinatario;
  String destinatario;
  String idDireccionLlegada;
  String direccionLlegada;
  String idConductor;
  String conductor;
  String idVehiculo;
  String vehiculo;
  String idTransportista;
  String transportista;
  String guiaRemisionTransportista;
  String facturaTransportista;
  String importeTransportista;
  String comentarioTransportista;
  String idEstado;
  String nombreEstado;
  String idCliente;
  String cliente;
  String origen;
  String destino;
  String usuario;
  String idUsuarioReg;
  String aceptada_por_sunat;
  String sunat_description;
  String sunat_note;
  String sunat_responsecode;
  String sunat_soap_error;
  String num_guia;
  String serie_num;
  String enlace_del_pdf;
  String cadena_para_codigo_qr;

  factory GuiaRemAux.fromJsonnnnn(Map<String, dynamic> json) {
    final aceptada_por_sunat = json["aceptada_por_sunat"] as String;
    final sunat_description = json["sunat_description"] as String;
    final sunat_note = json["sunat_note"] as String;
    final sunat_responsecode = json["sunat_responsecode"] as String;
    final sunat_soap_error = json["sunat_soap_error"] as String;
    final num_guia = json["num_guia"] as String;
    final serie_num = json["serie_num"] as String;
    final enlace_del_pdf = json["enlace_del_pdf"] as String;
    final cadena_para_codigo_qr = json["cadena_para_codigo_qr"] as String;

    return GuiaRemAux(
        aceptada_por_sunat: aceptada_por_sunat,
        sunat_description: sunat_description,
        sunat_note: sunat_note,
        sunat_responsecode: sunat_responsecode,
        sunat_soap_error: sunat_soap_error,
        num_guia: num_guia,
        serie_num: serie_num,
        enlace_del_pdf: enlace_del_pdf,
        cadena_para_codigo_qr: cadena_para_codigo_qr);
  }

  factory GuiaRemAux.fromJson(Map<String, dynamic> json) => GuiaRemAux(
        idGuiaRemision: json["id_guia_remision"],
        nmSolicitud: json["nm_solicitud"],
        fecha: json["fecha"],
        fechaTraslado: json["fecha_traslado"],
        serie: json["serie"],
        numeroGuia: json["numero_guia"],
        idVia: json["id_via"],
        nombreVia: json["nombre_via"],
        idTipoVia: json["id_tipo_via"],
        tipoViaCarga: json["tipo_via_carga"],
        idAgente: json["id_agente"],
        agente: json["agente"],
        idRemitente: json["id_remitente"],
        remitente: json["remitente"],
        idDireccionPartida: json["id_direccion_partida"],
        direccionPartida: json["direccion_partida"],
        idDestinatario: json["id_destinatario"],
        destinatario: json["destinatario"],
        idDireccionLlegada: json["id_direccion_llegada"],
        direccionLlegada: json["direccion_llegada"],
        idConductor: json["id_conductor"],
        conductor: json["conductor"],
        idVehiculo: json["id_vehiculo"],
        vehiculo: json["vehiculo"],
        idTransportista: json["id_transportista"],
        transportista: json["transportista"],
        guiaRemisionTransportista: json["guia_remision_transportista"],
        facturaTransportista: json["factura_transportista"],
        importeTransportista: json["importe_transportista"],
        comentarioTransportista: json["comentario_transportista"],
        idEstado: json["id_estado"],
        nombreEstado: json["nombre_estado"],
        idCliente: json["id_cliente"],
        cliente: json["cliente"],
        origen: json["origen"],
        destino: json["destino"],
        usuario: json["usuario"],
        idUsuarioReg: json["id_usuario_reg"],
        aceptada_por_sunat: json["aceptada_por_sunat"],
        sunat_description: json["sunat_description"],
        sunat_note: json["sunat_note"],
        sunat_soap_error: json["sunat_soap_error"],
        sunat_responsecode: json["sunat_responsecode"],
        num_guia: json["num_guia"],
        serie_num: json["serie_num"],
        enlace_del_pdf: json["enlace_del_pdf"],
        cadena_para_codigo_qr: json["cadena_para_codigo_qr"],
      );

  Map<String, dynamic> toJson() => {
        "id_guia_remision": idGuiaRemision,
        "nm_solicitud": nmSolicitud,
        "fecha": fecha,
        "fecha_traslado": fechaTraslado,
        "serie": serie,
        "numero_guia": numeroGuia,
        "id_via": idVia,
        "nombre_via": nombreVia,
        "id_tipo_via": idTipoVia,
        "tipo_via_carga": tipoViaCarga,
        "id_agente": idAgente,
        "agente": agente,
        "id_remitente": idRemitente,
        "remitente": remitente,
        "id_direccion_partida": idDireccionPartida,
        "id_destinatario": idDestinatario,
        "destinatario": destinatario,
        "id_direccion_llegada": idDireccionLlegada,
        "id_conductor": idConductor,
        "conductor": conductor,
        "id_vehiculo": idVehiculo,
        "vehiculo": vehiculo,
        "id_transportista": idTransportista,
        "transportista": transportista,
        "guia_remision_transportista": guiaRemisionTransportista,
        "factura_transportista": facturaTransportista,
        "importe_transportista": importeTransportista,
        "comentario_transportista": comentarioTransportista,
        "id_estado": idEstado,
        "nombre_estado": nombreEstado,
        "cliente": cliente,
        "origen": origen,
        "destino": destino,
        "usuario": usuario,
        "id_usuario_reg": idUsuarioReg,
        "aceptada_por_sunat": aceptada_por_sunat,
        "sunat_description": sunat_description,
        "sunat_note": sunat_note,
        "sunat_soap_error": sunat_soap_error,
        "sunat_responsecode": sunat_responsecode,
        "num_guia": num_guia,
        "serie_num": serie_num,
        "enlace_del_pdf": enlace_del_pdf,
        "cadena_para_codigo_qr": cadena_para_codigo_qr,
      };
}
