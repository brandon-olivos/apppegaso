import 'dart:convert';

import 'package:Pegaso/src/Pages/Login/modelLogin.dart';
import 'package:Pegaso/src/data/models/guia_rem_cliente_m.dart';
import 'package:sqflite/sqflite.dart';

class DatabasePr {
  Database _db;

  static final DatabasePr db = DatabasePr._();
  DatabasePr._();

  Future<Database> get database async {
    if (_db = null) return _db;

    _db = await initDB();

    return _db;
  }

  Future initDB() async {
    ///if(_db )
    _db = await openDatabase(
      'pegasoprod.db',
      version: 1,
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
        db.execute("CREATE TABLE token(id INTEGER PRIMARY KEY,estado, token)");
      },
    );
  }

//Insert
  Future<void> insertToken(TokenUsuario tokenUsuario) async {
    await DatabasePr.db.initDB();

    var a = await _db?.insert("token", tokenUsuario.toMap());
    print(a.toString());
  }

  Future getUltimoToken() async {
    await DatabasePr.db.initDB();

    final res = await _db
        ?.rawQuery("SELECT token FROM token ORDER BY token DESC LIMIT 1;");

    List<TokenUsuario> list =
        res.isNotEmpty ? res.map((e) => TokenUsuario.map(e)).toList() : [];

    return list[0].token;
  }

  Future getUltimoTokenle() async {
    await DatabasePr.db.initDB();

    final res = await _db
        ?.rawQuery("SELECT token FROM token ORDER BY token DESC LIMIT 1;");

    List<TokenUsuario> list =
        res.isNotEmpty ? res.map((e) => TokenUsuario.map(e)).toList() : [];
    return list.length;
  }

  Future getDtaGRC() async {
    await DatabasePr.db.initDB();

    final res = await _db
        ?.rawQuery("SELECT * FROM guia_remision_cliente ORDER BY id ASC;");

    List<GuiaRemClienteM> list = res.isNotEmpty
        ? res.map((e) => GuiaRemClienteM.fromMap(e)).toList()
        : [];

    return list;
  }

  Future getDtaGRCjs() async {
    await DatabasePr.db.initDB();
    //GuiaRemClienteM guiaRemClienteM;
    final res = await _db
        ?.rawQuery("SELECT * FROM guia_remision_cliente ORDER BY id ASC;");

    List<GuiaRemClienteM> list = res.isNotEmpty
        ? res.map((e) => GuiaRemClienteM.fromJson(e)).toList()
        : [];

    print(JsonEncoder().convert(res));

    return JsonEncoder().convert(res);
  }

  Future getporid(i) async {
    await DatabasePr.db.initDB();

    final res = await _db?.rawQuery(
        "SELECT * FROM guia_remision_cliente where id = $i ORDER BY id ASC;");

    //print()
    List<GuiaRemClienteM> list = res.isNotEmpty
        ? res.map((e) => GuiaRemClienteM.fromMap(e)).toList()
        : [];

    return list;
  }

  Future eliminarPorid(i) async {
    await DatabasePr.db.initDB();

    final res =
        await _db?.rawQuery("DELETE FROM guia_remision_cliente where id = $i;");

    return res;
  }

  Future eliminarTodo() async {
    await DatabasePr.db.initDB();

    final res = await _db?.rawQuery("DELETE FROM guia_remision_cliente");

    return res;
  }

  Future eliminarTokn() async {
    eliminarTodo();
    await DatabasePr.db.initDB();
    final res = await _db?.rawQuery("DELETE FROM token");
    return res;
  }
}
