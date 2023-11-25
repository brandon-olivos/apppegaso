import 'package:Pegaso/src/Pages/GuiaRemAuxiliar/listaGuiaRemAuxiliar.dart';
import 'package:Pegaso/src/Pages/ProcesarGuias/procesarGuias.dart';
import 'package:Pegaso/src/Pages/Seguimiento/seguimiento_auxiliar/SeguimientoAuxiliar.dart';
import 'package:Pegaso/src/data/db/guia_rem_cliente.dart';
import 'package:Pegaso/src/data/db/token.dart';
import 'package:Pegaso/src/pages/Login/config_usuario.dart';
import 'package:Pegaso/src/pages/home/appbar/AppBar.dart';
import 'package:Pegaso/src/util/app-config.dart';
import 'package:flutter/material.dart';
import 'package:Pegaso/src/Pages/Login/login.dart';
import 'package:Pegaso/src/Pages/Asignaciones/asignaciones.dart';
import 'package:Pegaso/src/Pages/Reparacion/Reparacion.dart';

class HomeSistema extends StatefulWidget {
  static String route = '/';
  String usuario;
  HomeSistema(this.usuario);

  @override
  _HomeSistemaState createState() => _HomeSistemaState();
}

class _HomeSistemaState extends State<HomeSistema> {
  int currenIndex = 0;

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

    botones(nombre, icono) {
      return InkWell(
        onTap: () {
          switch (nombre) {
            case 'Asignaciones':
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AsignacionesPage(
                          titulo: "Asignaciones",
                        )),
              );
              break;
            case 'Guias Remision': //GuiaRemAuxiliar
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListaGuiaRemAuxiliar(
                          titulo: 'Guias Remision',
                        )),
              );
              break;
            case 'Manifiestos':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReparacionPage()),
              );
              break;

            case 'Procesar Guias':
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProcesarGuias(
                          titulo: 'Procesar Guias',
                        )),
              );
              break;
            case 'Seguimiento':
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SeguimientoAuxiliar('Seguimiento')),
              );
              break;
          }
        },
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    icono,
                    color: Colors.orange,
                    size: 60,
                  ),
                ],
              ),
              ListTile(
                title: Center(
                    child: Text("" + nombre,
                        textAlign: TextAlign.center,
                        style: style.copyWith(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold))),
              ),
            ],
          ),
        ),
      );
    }

    List listPages = [
      Container(
          child: Column(
        children: <Widget>[
          Expanded(
              flex: 6,
              child: Center(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Center(
                      child: GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        shrinkWrap: true,
                        /*  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,*/
                        children: [
                          // botones("Asignaciones", Icons.app_registration),
                          //botones( "Procesar Guias", Icons.assignment_late_outlined),
                          botones("Guias Remision", Icons.book),
                          botones("Seguimiento", Icons.camera_enhance_outlined),
                          //    botones("Manifiestos",Icons.book),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ],
      )),
    ];

    return Scaffold(
      /*appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          actions: [
            InkWell(
              onTap: () {
                 setState(() {
                   DatabasePr.db.eliminarTokn();
                 });
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: Icon(Icons.close_fullscreen_sharp),
            )
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(AppConfig.title)],
          ),
        ), */
      //body: listPages[currenIndex]);
      body: Stack(
        children: <Widget>[AppBarPegaso(), listPages[currenIndex]],
      ),
      floatingActionButton: FloatingActionButton(
          focusColor: Colors.amber,
          backgroundColor: Colors.orange,
          child: const Icon(Icons.manage_accounts),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ConfiguracionUsuarioPage(
                        titulo: widget.usuario,
                      )),
            );
          }),
    );
  }
}
