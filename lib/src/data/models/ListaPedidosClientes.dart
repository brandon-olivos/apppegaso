import 'dart:convert';

class ListaPedidosClientes2 {
  List<ListaPedidosClientes> items = [];
  ListaPedidosClientes2();
  ListaPedidosClientes2.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new ListaPedidosClientes.fromJson(item);
      items.add(_listarTrabajador);
    }
  }
}

// class PedidoClienteSave {
//   PedidoClienteSave({
//     this.idPedidoCliente = 0,
//     this.fecha = '',
//     this.horaRecojo = '',
//     this.idDireccionRecojo = '',
//     this.tipoServicio = '',
//     this.idTipoUnidad = '',
//     this.nombreArea = '',
//     this.nombrePerfil = '',
//   });

//   int idPedidoCliente;
//   String fecha;
//   String horaRecojo;
//   String idDireccionRecojo;
//   String tipoServicio;
//   String idTipoUnidad;

//   String nombreArea;
//   String nombrePerfil;

//   factory PedidoClienteSave.fromJson(Map<String, dynamic> json) =>
//       PedidoClienteSave(
//         idPedidoCliente: json["id_pedido_cliente"],
//         fecha: json["fecha"],
//         horaRecojo: json["hora_recojo"],
//         idDireccionRecojo: json["id_direccion_recojo"],
//         tipoServicio: json["tipo_servicio"],
//         idTipoUnidad: json["id_tipo_unidad"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id_pedido_cliente": idPedidoCliente,
//         "fecha": fecha,
//         "hora_recojo": horaRecojo,
//         "id_direccion_recojo": idDireccionRecojo,
//         "tipo_servicio": tipoServicio,
//         "id_tipo_unidad": idTipoUnidad,
//       };
// }

List<ListaPedidosClientes> listaPedidosClientesFromJson(String str) =>
    List<ListaPedidosClientes>.from(
        json.decode(str).map((x) => ListaPedidosClientes.fromJson(x)));

String listaPedidosClientesToJson(List<ListaPedidosClientes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListaPedidosClientes {
  ListaPedidosClientes(
      {this.id_pedido_cliente = '',
      this.nm_solicitud = '',
      this.fecha = '',
      this.hora_recojo = '',
      this.tipo_servicio = '',
      this.tipo_servicios = '',
      this.nombre_estado = '',
      this.id_cliente = '',
      this.id_direccion_recojo = '',
      this.id_tipo_unidad = '',
      this.nombre_producto = '',
      this.descripcion = '',
      this.id_estado = '',
      this.direccion = ''});

  String id_pedido_cliente;
  String nm_solicitud;
  String fecha;
  String hora_recojo;
  String tipo_servicio;
  String tipo_servicios;
  String nombre_estado;
  String id_cliente;
  String id_direccion_recojo;
  String id_tipo_unidad;

  String nombre_producto;
  String descripcion;
  String direccion;
  String id_estado;

  factory ListaPedidosClientes.fromJson(Map<String, dynamic> json) =>
      ListaPedidosClientes(
          id_pedido_cliente: json['id_pedido_cliente'],
          nm_solicitud: json['nm_solicitud'],
          fecha: json['fecha'],
          hora_recojo: json['hora_recojo'],
          tipo_servicio: json['tipo_servicio'],
          tipo_servicios: json['tipo_servicios'],
          nombre_estado: json['nombre_estado'],
          id_cliente: json['id_cliente'],
          id_direccion_recojo: json['id_direccion_recojo'],
          id_tipo_unidad: json['id_tipo_unidad'],
          nombre_producto: json['nombre_producto'],
          descripcion: json['descripcion'],
          id_estado: json['id_estado'],
          direccion: json['direccion']);

  Map<String, dynamic> toJson() => {
        "id_pedido_cliente": id_pedido_cliente,
        "nm_solicitud": nm_solicitud,
        "fecha": fecha,
        "hora_recojo": hora_recojo,
        "tipo_servicio": tipo_servicio,
        "tipo_servicios": tipo_servicios,
        "nombre_estado": nombre_estado,
        "id_cliente": id_cliente,
        "id_direccion_recojo": id_direccion_recojo,
        "id_tipo_unidad": id_tipo_unidad,
        "nombre_producto": nombre_producto,
        "descripcion": descripcion,
        "id_estado": id_estado,
        "direccion": direccion
      };
}
