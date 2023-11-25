import 'dart:convert';

class ListaSeguimientoNuevos2 {
  List<ListaSeguimientoNuevos> items = [];
  ListaSeguimientoNuevos2();
  ListaSeguimientoNuevos2.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new ListaSeguimientoNuevos.fromJson(item);
      items.add(_listarTrabajador);
    }
  }
}

List<ListaSeguimientoNuevos> listaSeguimientoNuevosFromJson(String str) =>
    List<ListaSeguimientoNuevos>.from(
        json.decode(str).map((x) => ListaSeguimientoNuevos.fromJson(x)));

String listaSeguimientoNuevosToJson(List<ListaSeguimientoNuevos> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListaSeguimientoNuevos {
  ListaSeguimientoNuevos({
    this.id_guia_remision = '',
    this.numero_guia = '',
    this.cuenta = '',
    this.usuario = '',
    this.direccion = '',
    this.nombre_provincia = '',
    this.fecha_traslado = '',
    this.nombre_estado = '',
    this.tipo = '',
    this.fecha = '',
    this.origen = '',
    this.destino = '',
    this.remitente = '',
    this.destinatario = '',
    //
    this.via = '',
    this.direccion_partida = '',
    this.direccion_llegada = '',
    this.id_estado = '',
    this.comentario = '',
    this.id_cliente = '',
    this.ip_server = '',
    this.nombre_archivo = '',
    this.nombre_ruta = '',
    this.nombre_ruta_inicio = '',
    this.id_archivo = '',
    this.razon_social = '',
    this.nm_solicitud = '',
    this.id_entidad = '',
    this.id_persona = '',
    this.notificacion = '',
    this.fecha_reg = '',
  });

  String id_guia_remision;
  String numero_guia;
  String cuenta;
  String usuario;
  String direccion;
  String nombre_provincia;
  String fecha_traslado;
  String nombre_estado;
  String tipo;
  String fecha;
  String origen;
  String destino;
  String remitente;
  String destinatario;
//
  String via;
  String direccion_partida;
  String direccion_llegada;
  String id_estado;
  String comentario;

  String id_cliente;
  String ip_server;
  String nombre_archivo;
  String nombre_ruta;
  String nombre_ruta_inicio;
  String id_archivo;
  String razon_social;

  String nm_solicitud;
  String id_entidad;
  String id_persona;
  String notificacion;
  String fecha_reg;

  factory ListaSeguimientoNuevos.fromJson(Map<String, dynamic> json) =>
      ListaSeguimientoNuevos(
          id_guia_remision: json['id_guia_remision'],
          numero_guia: json['numero_guia'],
          cuenta: json['cuenta'],
          usuario: json['usuario'],
          direccion: json['direccion'],
          nombre_provincia: json['nombre_provincia'],
          fecha_traslado: json['fecha_traslado'],
          nombre_estado: json['nombre_estado'],
          tipo: json['tipo'],
          fecha: json['fecha'],
          origen: json['origen'],
          destino: json['destino'],
          remitente: json['remitente'],
          destinatario: json['destinatario'],
          //
          via: json['via'],
          direccion_partida: json['direccion_partida'],
          direccion_llegada: json['direccion_llegada'],
          id_estado: json['id_estado'],
          comentario: json['comentario'],
          //
          id_cliente: json['id_cliente'],
          ip_server: json['ip_server'],
          nombre_archivo: json['nombre_archivo'],
          nombre_ruta: json['nombre_ruta'],
          nombre_ruta_inicio: json['nombre_ruta_inicio'],
          id_archivo: json['id_archivo'],
          razon_social: json['razon_social'],
          //
          nm_solicitud: json['nm_solicitud'],
          id_entidad: json['id_entidad'],
          id_persona: json['id_persona'],
          notificacion: json['notificacion'],
          fecha_reg: json['fecha_reg']);

  Map<String, dynamic> toJson() => {
        "id_guia_remision": id_guia_remision,
        "numero_guia": numero_guia,
        "cuenta": cuenta,
        "usuario": usuario,
        "direccion": direccion,
        "nombre_provincia": nombre_provincia,
        "fecha_traslado": fecha_traslado,
        "nombre_estado": nombre_estado,
        "tipo": tipo,
        "fecha": fecha,
        "origen": origen,
        "destino": destino,
        "remitente": remitente,
        "destinatario": destinatario,
        //
        "via": via,
        "direccion_partida": direccion_partida,
        "direccion_llegada": direccion_llegada,
        "id_estado": id_estado,
        "comentario": comentario,
        //
        "id_cliente": id_cliente,
        "ip_server": ip_server,
        "nombre_archivo": nombre_archivo,
        "nombre_ruta": nombre_ruta,
        "nombre_ruta_inicio": nombre_ruta_inicio,
        "id_archivo": id_archivo,
        "razon_social": razon_social,
        //
        "nm_solicitud": nm_solicitud,
        "id_entidad": id_entidad,
        "id_persona": id_persona,
        "notificacion": notificacion,
        "fecha_reg": fecha_reg
      };
}
