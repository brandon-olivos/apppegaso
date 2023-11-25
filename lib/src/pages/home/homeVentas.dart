import 'package:Pegaso/src/pages/SeguimientoNuevo/SeguimientoAuxiliarNuevo.dart';
import 'package:Pegaso/src/pages/Login/config_usuario.dart';
import 'package:Pegaso/src/pages/home/appbar/AppBar.dart';
import 'package:flutter/material.dart';

class HomeVentas extends StatefulWidget {
  static String route = '/';

  @override
  _HomeVentasState createState() => _HomeVentasState();
}

class _HomeVentasState extends State<HomeVentas> {
  int currenIndex = 0;

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

    botones(nombre, icono) {
      return InkWell(
        onTap: () {
          switch (nombre) {
            case 'Seguimiento':
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SeguimientoAuxiliar(
                          titulo: "Seguimiento",
                        )),
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
                        children: [
                          botones("Seguimiento", Icons.track_changes_rounded),
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
                        titulo: "Usuario",
                      )),
            );
          }),
    );
  }
}
