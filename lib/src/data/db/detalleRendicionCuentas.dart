import 'dart:convert';

import 'package:Pegaso/src/data/models/detalleRendicionCuentasM.dart';
import 'package:Pegaso/src/data/models/listaRendicionCuenta.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseDRC {
  Database _db;

  static final DatabaseDRC db = DatabaseDRC._();
  DatabaseDRC._();

  Future<Database> get database async {
    if (_db = null) return _db;

    _db = await initDB();

    return _db;
  }

  Future initDB() async {
    ///if(_db )
    _db = await openDatabase(
      'pegasoproddocument.db',
      version: 2,
      onCreate: (Database db, int version) {
        db.execute('CREATE TABLE detalleRendicionCuentas('
            'id INTEGER PRIMARY KEY,'
            'fecha,'
            'proveedor,'
            'ndocumento,'
            'concepto,'
            'monto)');
      },
    );
  }

//Insert
  Future<void> insertDetalleRC(DetalleRenCuenModel detalleRenCuenModel) async {
    await DatabaseDRC.db.initDB();

    print(detalleRenCuenModel.fecha);
    print(detalleRenCuenModel.concepto);
    print(detalleRenCuenModel.monto);
    print(detalleRenCuenModel.ndocumento);
    print(detalleRenCuenModel.toMap());

    var a = await _db.insert(
        "detalleRendicionCuentas", detalleRenCuenModel.toMap());
  }

  Future getDtaGRC() async {
    await DatabaseDRC.db.initDB();

    final res = await _db
        .rawQuery("SELECT * FROM detalleRendicionCuentas ORDER BY id ASC;");

    List<DetalleRenCuenModel> list = res.isNotEmpty
        ? res.map((e) => DetalleRenCuenModel.fromMap(e)).toList()
        : [];
    print(list);
    return list;
  }

  Future getDtjsGRC() async {
    await DatabaseDRC.db.initDB();
    //GuiaRemClienteM guiaRemClienteM;
    final res = await _db
        .rawQuery("SELECT * FROM detalleRendicionCuentas ORDER BY id ASC;");

    List<DetalleRenCuenModel> list = res.isNotEmpty
        ? res.map((e) => DetalleRenCuenModel.fromJson(e)).toList()
        : [];

    print(JsonEncoder().convert(res));

    return JsonEncoder().convert(res);
  }

  Future traersumatotal() async {
    await DatabaseDRC.db.initDB();

    final res = await _db
        .rawQuery("SELECT SUM(monto) as total from detalleRendicionCuentas");
    return res;
  }

  Future eliminarPorid(i) async {
    await DatabaseDRC.db.initDB();

    final res = await _db
        .rawQuery("DELETE FROM detalleRendicionCuentas where id = $i;");

    return res;
  }

  Future eliminarTodo() async {
    await DatabaseDRC.db.initDB();

    final res = await _db.rawQuery("DELETE FROM detalleRendicionCuentas");

    return res;
  }

  Future<void> editGRC(DetalleRenCuenModel detalleRenCuenModel, id) async {
    await DatabaseDRC.db.initDB();

    final res = await _db.rawQuery(
        "UPDATE guia_remision_cliente SET fecha = '${detalleRenCuenModel.fecha}', proveedor = '${detalleRenCuenModel.proveedor}',ndocumento='${detalleRenCuenModel.ndocumento}', concepto='${detalleRenCuenModel.concepto}', monto = '${detalleRenCuenModel.monto}''   WHERE id=$id;");

    print(res.toString());
  }
}
