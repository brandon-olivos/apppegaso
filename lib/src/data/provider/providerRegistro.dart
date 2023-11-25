import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:Pegaso/src/data/db/token.dart';

var dato;

class ProviderRegistro {
  mostrarDatos() async {
    //  await DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getUltimoToken();

    dato = abc.toString();
  }

  static Map<String, String> get headers {
    //tokenUsuario.toMap(DatabasePr.db.getUltimoToken());

    return {
      // TODO: TOKEN DEL SQLITE

      "Authorization": "Bearer $dato",
      'Content-Type': 'application/json'
    };
  }
}
