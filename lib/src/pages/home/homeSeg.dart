import 'package:Pegaso/src/util/app-params.dart';
import 'package:flutter/material.dart';
import 'package:Pegaso/src/Pages/Login/login.dart';
import 'package:Pegaso/src/Pages/Asignaciones/asignaciones.dart';
import 'package:Pegaso/src/Pages/Reparacion/Reparacion.dart';
import 'package:Pegaso/src/Pages/Solicitudes/Solicitudes.dart';

import 'botonNavigationBar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class HomeSegPage extends StatefulWidget {
  static String route = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeSegPage> {
  int currenIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // AppParams.requerirPermisosLoca();
  }

  @override
  Widget build(BuildContext context) {
    //  AppParams.requerirPermisosLoca();
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    // f(s) {}
    //
    botones(nombre) {
      return InkWell(
        onTap: () {
          if (nombre == "Asignaciones") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AsignacionesPage(
                        titulo: "Asignaciones",
                      )),
            );
          } else if (nombre == "Guias Remision Ax") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReparacionPage()),
            );
          } else if (nombre == "Manifiestos") {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          }
        },
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.local_shipping,
                    color: Colors.orange,
                  ),
                ],
              ),
              ListTile(
                // leading: Icon(Icons.photo_album, color: Colors.blue),
                title: Center(
                    child: Text("" + nombre,
                        textAlign: TextAlign.center,
                        style: style.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold))),
                // subtitle: Text(" Asignaciones"),
              ),
              /*  Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                      child: Text("Ok"),
                      onPressed: () {
                        Text("Ok");
                      }),
                  FlatButton(
                      child: Text("Cancelar"),
                      onPressed: () {
                        Text("Cancelar");
                      })
                ],
              )*/
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
                    padding: const EdgeInsets.all(36.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //  botones(),
                        botones("Asignaciones"),
                        botones("Guias Remision Ax"),
                        botones("Manifiestos")
                      ],
                    ),
                  ),
                ),
              )),
        ],
      )),
      Container(
        child: SolicitudesPage(),
      ),
      Container(
        child: Text("data2"),
      ),
    ];

    return Scaffold(
        bottomNavigationBar: BottomNavyBar(
          //   items: items,
          selectedIndex: currenIndex,

          onItemSelected: (index) {
            setState(() {
              currenIndex = index;
            });
          },

          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                icon: Icon(Icons.local_shipping),
                title: Text("Servicio"),
                activeColor: Colors.blue[900],
                inactiveColor: Colors.black),
            BottomNavyBarItem(
                icon: Icon(Icons.text_snippet),
                title: Text("Solicitudes"),
                activeColor: Colors.blue[900],
                inactiveColor: Colors.black),
            BottomNavyBarItem(
                icon: Icon(Icons.handyman),
                title: Text("Configuracion"),
                activeColor: Colors.blue[900],
                inactiveColor: Colors.black),
          ],
        ),
        appBar: AppBar(
            backgroundColor: Colors.indigo[900],
            actions: [
              InkWell(
                onTap: () {
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
              children: [
                Text("PEGASO"),
              ],
            )),
        body: listPages[currenIndex]);
  }
}
