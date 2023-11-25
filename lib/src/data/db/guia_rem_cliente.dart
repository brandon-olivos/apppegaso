import '../models/guia_rem_cliente_m.dart';
import 'package:sqflite/sqflite.dart';

class DatabasePrGRC {
  Database _db;

  static final DatabasePrGRC db = DatabasePrGRC._();
  DatabasePrGRC._();

  Future<Database> get database async {
    if (_db = null) return _db;

    _db = await initDB();

    return _db;
  }

  Future initDB() async {
    ///if(_db )
    _db = await openDatabase(
      'pegasoprod.db',
      version: 2,
      onCreate: (Database db, int version) {
        db.execute('CREATE TABLE guia_remision_cliente('
            'id INTEGER PRIMARY KEY,'
            'id_guia_remision_cliente,'
            'id_temporal_tabla_gr,'
            'id_guia_remision,'
            'grs,'
            'gr,'
            'ft,'
            'delivery,'
            'oc,'
            'cantidad,'
            'peso,'
            'volumen,'
            'alto,'
            'largo,'
            'ancho,'
            'id_tipo_carga,'
            'tipo_carga,'
            'descripcion)');
      },
    );
  }

//Insert
  Future<void> insertGRC(GuiaRemClienteM guiaRemClienteM) async {
    await DatabasePrGRC.db.initDB();

    var a = await _db?.insert("guia_remision_cliente", guiaRemClienteM.toMap());
    print(a.toString());
  }

  //editar
  Future<void> editGRC(GuiaRemClienteM guiaRemClienteM, id) async {
    await DatabasePrGRC.db.initDB();

    final res = await _db.rawQuery(
        "UPDATE guia_remision_cliente SET grs = '${guiaRemClienteM.grs}', gr = '${guiaRemClienteM.gr}',ft='${guiaRemClienteM.ft}', oc ='${guiaRemClienteM.oc}',cantidad='${guiaRemClienteM.cantidad}', peso='${guiaRemClienteM.peso}', volumen = '${guiaRemClienteM.volumen}', alto='${guiaRemClienteM.alto}', largo='${guiaRemClienteM.largo}', ancho='${guiaRemClienteM.ancho}',id_tipo_carga='${guiaRemClienteM.idTipoCarga}', tipo_carga='${guiaRemClienteM.tipoCarga}', descripcion='${guiaRemClienteM.descripcion}'   WHERE id=$id;");

    print(res.toString());
  }
}
