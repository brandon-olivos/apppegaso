import 'package:Pegaso/src/pages/Direcciones/Direcciones.dart';
import 'package:Pegaso/src/pages/Entidades/Entidades.dart';
import 'package:Pegaso/src/pages/Login/config_usuario.dart';
import 'package:Pegaso/src/pages/PedidosOperaciones/PedidosOperaciones.dart';
import 'package:Pegaso/src/pages/home/appbar/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:Pegaso/src/Pages/Asignaciones/asignaciones.dart';

// ignore: must_be_immutable
class HomeOperacionesInicio extends StatefulWidget {
  static String route = '/';
  String usuario;
  HomeOperacionesInicio(this.usuario);

  @override
  _HomeSistemaState createState() => _HomeSistemaState();
}

class _HomeSistemaState extends State<HomeOperacionesInicio> {
  int currenIndex = 0;

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

    botones(nombre, icono) {
      return InkWell(
        onTap: () {
          switch (nombre) {
            case 'PEDIDOS CLIENTES':
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PedidosOperacionesPage(
                        // titulo: "PedidosOperacionesPage",
                        )),
              );
              break;

            case 'DIRECCIONES':
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DireccionesPage(
                        // titulo: "PedidosOperacionesPage",
                        )),
              );
              break;

            case 'ENTIDADES':
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EntidadesPage(
                        // titulo: "PedidosOperacionesPage",
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          botones("PEDIDOS CLIENTES",
                              Icons.camera_enhance_outlined),
                          botones("ENTIDADES", Icons.all_inbox_sharp),
                          botones("DIRECCIONES", Icons.camera_enhance_outlined),
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
