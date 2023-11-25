import 'package:Pegaso/src/Pages/Seguimiento/seguimiento_agencia/SeguimientoAgCl.dart';
import 'package:Pegaso/src/Pages/Seguimiento/seguimiento_agencia/SeguimientoAgencia.dart';
import 'package:Pegaso/src/Pages/Seguimiento/seguimiento_agencia/SeguimientoAgenciaAte.dart';
import 'package:Pegaso/src/data/models/ListaSeguimientoAgente.dart';
import 'package:Pegaso/src/data/provider/providerLista.dart';
import 'package:Pegaso/src/util/app-config.dart';
import 'package:flutter/material.dart';
import 'package:Pegaso/src/Pages/Login/login.dart';
import 'package:Pegaso/src/Pages/Reparacion/Reparacion.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class HomePageAg extends StatefulWidget {
  static String route = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageAg> {
  int currenIndex = 0;
  final _providerLista = new ProviderLista();

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    // f(s) {}
    //
    botones(nombre) {
      return InkWell(
        onTap: () async {
          if (nombre == "Seguimiento") {
            await _providerLista.getListaSeguimientoAgente();
            await Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => SeguimientoAgenciaPage(
                      // titulo: "Seguimiento",
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
            ],
          ),
        ),
      );
    }

    List listPages = [
      SeguimientoAgenciaPage(),
      SeguimientoAgenciaAtePage(),
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
                title: Text("Seguimiento"),
                activeColor: Colors.blue[900],
                inactiveColor: Colors.black),
            BottomNavyBarItem(
                icon: Icon(Icons.text_snippet),
                title: Text("Atendidos"),
                activeColor: Colors.blue[900],
                inactiveColor: Colors.black),
          ],
        ),
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
            ),
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
              Text(AppConfig.title),
            ],
          ),
        ),
        body: listPages[currenIndex]);
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final _providerLista = new ProviderLista();
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => this.query = '', icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => this.close(context, null),
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    Future<Null> refreshList() async {
      await Future.delayed(Duration(seconds: 1));
      _providerLista.getListaSeguimientoAgenteBuscar();
    }

    ListTile _banTitle(ListaSeguimientoAgente band) {
      return ListTile(
        leading: CircleAvatar(
          child: Text(band.cuenta.substring(0, 2)),
          backgroundColor: Colors.blue[900],
        ),
        title: Text(band.numero_guia, style: TextStyle(fontSize: 13)),
        subtitle: new Text(band.direccion, style: TextStyle(fontSize: 13)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${band.fecha_traslado}',
              style: TextStyle(fontSize: 13),
            ),
            Container(
              width: 150,
              child: Text(
                '${band.nombre_provincia}',
                style: TextStyle(fontSize: 13),
              ),
            )
          ],
        ),
        onTap: () async {
          //  _providerLista.getVia();
          await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => SeguimientoAgClPage(
                      idGuiaRem: band.id_guia_remision,
                      tipo: band.tipo,

                      //id: band.id_guia_remision,
                      //  fecha: band.fecha_traslado,
                    )),
          );
        },
      );
    }

    if (query.trim().length == 0) {
      return Text('no hay valor');
    }

    return FutureBuilder<List<ListaSeguimientoAgente>>(
      future: _providerLista.getListaSeguimientoAgenteBuscar(busca: query),
      builder: (BuildContext context,
          AsyncSnapshot<List<ListaSeguimientoAgente>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.hasData == false) {
            return Center(
              child: Text("¡No existen registros"),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
        final listaPersonalAux = snapshot.data;

        if (listaPersonalAux.length == 0) {
          return Center(
            child: Text("No hay informacion"),
          );
        } else {
          //   setState(() {});
          return Container(
            child: RefreshIndicator(
                child: ListView.builder(
                  itemCount: listaPersonalAux.length,
                  itemBuilder: (context, i) => _banTitle(listaPersonalAux[i]),
                ),
                onRefresh: refreshList),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListTile(
      title: Text(''),
    );
  }
}
