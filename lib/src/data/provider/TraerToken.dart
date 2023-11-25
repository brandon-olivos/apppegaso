import 'dart:async';

import 'package:Pegaso/src/data/db/token.dart';

var dato;

class TraerToken {
  Future<String> mostrarDatos() async {
    //  await DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getUltimoToken();
    dato = abc.toString();
    return abc.toString();
  }

  static Map<String, String> get headers {
    TraerToken().mostrarDatos();

    return {
      // TODO: TOKEN DEL SQLITE

      "Authorization": "Bearer ${dato}",
      'Content-Type': 'application/json'
    };
  }

  static Map<String, String> get headerslog {
    TraerToken().mostrarDatos();

    return {
      // TODO: TOKEN DEL SQLITE

      "Authorization": "Bearer ${dato}",
    };
  }
}
