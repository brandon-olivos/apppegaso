class TipoServicios {
  List<TipoServicio> items = [];
  TipoServicios();
  TipoServicios.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTipoServicio = new TipoServicio.fromJson(item);
      items.add(_listarTipoServicio);
    }
  }
}

class TipoServicio {
  int id_producto;
  String cod_producto;
  String nombre_producto;
  String unidad_medida;

  TipoServicio({
    this.id_producto = 0,
    this.cod_producto = '',
    this.nombre_producto = '',
    this.unidad_medida = '',
  });

  factory TipoServicio.fromMap(Map<String, dynamic> obj) => TipoServicio(
        id_producto: obj['id_producto'],
        cod_producto: obj['cod_producto'],
        nombre_producto: obj['nombre_producto'],
        unidad_medida: obj['unidad_medida'],
      );

  factory TipoServicio.fromJson(Map<String, dynamic> obj) {
    return TipoServicio(
      id_producto: obj['id_producto'],
      cod_producto: obj['cod_producto'],
      nombre_producto: obj['nombre_producto'],
      unidad_medida: obj['unidad_medida'],
    );
  }
}

/*value="
<?= $p->id_producto ?>"><
?= $p->cod_producto . '::' 
. $p->nombre_producto . '::'
 . $p->unidad_medida ?>*/