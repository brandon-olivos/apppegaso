import 'package:Pegaso/src/Pages/Seguimiento/seguimiento_auxiliar/SeguimientoAgenciaAte.dart';
import 'package:Pegaso/src/Pages/Seguimiento/seguimiento_auxiliar/SeguimientoAuxiliarClAux.dart';
import 'package:Pegaso/src/Pages/Seguimiento/seguimiento_auxiliar/SeguimientoAuxiliarPage.dart';
import 'package:Pegaso/src/data/models/ListaSeguimientoAgente.dart';
import 'package:Pegaso/src/data/provider/providerLista.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SeguimientoAuxiliar extends StatefulWidget {
  String title;
  SeguimientoAuxiliar(this.title);

  @override
  _SeguimientoAuxiliarState createState() => _SeguimientoAuxiliarState();
}

class _SeguimientoAuxiliarState extends State<SeguimientoAuxiliar> {
  @override
  int currenIndex = 0;

  Widget build(BuildContext context) {
    List listPages = [
      SeguimientoAuxiliarPage(),
      SeguimientoAuxiliarAtePage(),
      Container(
        child: Text("data2"),
      ),
    ];

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
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
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(widget.title)],
          ),
        ),
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
      _providerLista.getListaSeguimientoAuxiliarBuscar();
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
          await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => SeguimientoAuxiliarClAux(
                      idGuiaRem: band.id_guia_remision,
                      tipo: band.tipo,
                    )),
          );
        },
      );
    }

    if (query.trim().length == 0) {
      return Text('no hay valor');
    }

    return FutureBuilder<List<ListaSeguimientoAgente>>(
      future: _providerLista.getListaSeguimientoAuxiliarBuscar(busca: query),
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

        if (listaPersonalAux?.length == 0) {
          return Center(
            child: Text("No hay informacion"),
          );
        } else {
          //   setState(() {});
          return Container(
            child: RefreshIndicator(
                child: ListView.builder(
                  itemCount: listaPersonalAux?.length,
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
    Future<Null> refreshList() async {
      await Future.delayed(Duration(seconds: 1));
      _providerLista.getListaSeguimientoAuxiliarBuscar();
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
          await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => SeguimientoAuxiliarClAux(
                      idGuiaRem: band.id_guia_remision,
                      tipo: band.tipo,
                    )),
          );
        },
      );
    }

    return FutureBuilder<List<ListaSeguimientoAgente>>(
      future: _providerLista.getListaSeguimientoAuxiliarBuscar(busca: query),
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

        if (listaPersonalAux?.length == 0) {
          return Center(
            child: Text("No hay informacion"),
          );
        } else {
          //   setState(() {});
          return Container(
            child: RefreshIndicator(
                child: ListView.builder(
                  itemCount: listaPersonalAux?.length,
                  itemBuilder: (context, i) => _banTitle(listaPersonalAux[i]),
                ),
                onRefresh: refreshList),
          );
        }
      },
    );
  }
}
