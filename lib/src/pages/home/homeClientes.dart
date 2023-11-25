import 'package:Pegaso/src/pages/SeguimientoCliente/SeguimientoCliente.dart';
import 'package:Pegaso/src/pages/Login/config_usuario.dart';
import 'package:Pegaso/src/pages/home/appbar/AppBar.dart';
import 'package:Pegaso/src/pages/home/homeClientesPedidos.dart';
import 'package:flutter/material.dart';

class HomeClientes extends StatefulWidget {
  static String route = '/';

  @override
  _HomeClientesState createState() => _HomeClientesState();
}

class _HomeClientesState extends State<HomeClientes> {
  int currenIndex = 0;

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

    botones(nombre, icono) {
      return InkWell(
        onTap: () {
          switch (nombre) {
            case 'Pedidos del Cliente':
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeClientesPedidos(
                          titulo: nombre,
                        )),
              );
              break;

            case 'Seguimiento de Pedidos':
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SeguimientoClientes(
                          titulo: "Seguimiento de Pedidos",
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
                          botones("Pedidos del Cliente",
                              Icons.format_list_numbered_rounded),
                          botones("Seguimiento de Pedidos",
                              Icons.track_changes_rounded),
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
                        titulo: "Usuario",
                      )),
            );
          }),
    );
  }
}
