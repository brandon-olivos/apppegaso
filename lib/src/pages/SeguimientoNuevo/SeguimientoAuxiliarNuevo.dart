import 'package:Pegaso/src/data/models/ListaSeguimientoNuevo.dart';
import 'package:Pegaso/src/data/provider/providerLista.dart';
import 'package:Pegaso/src/pages/SeguimientoNuevo/EditarSeguimientoNuevo.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SeguimientoAuxiliar extends StatefulWidget {
  String titulo;

  SeguimientoAuxiliar({this.titulo});
  @override
  _SeguimientoAuxiliarState createState() => _SeguimientoAuxiliarState();
}

class _SeguimientoAuxiliarState extends State<SeguimientoAuxiliar> {
  final _providerGuias = new ProviderLista();

  @override
  void initState() {
    super.initState();
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 10));
    _providerGuias.getListaSeguimientoNuevo('');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      refreshList();
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.indigo[900],
        title: Text(
          '${widget.titulo}',
          style: TextStyle(color: Colors.white),
        ),
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
        elevation: 1,
      ),
      body: FutureBuilder<List<ListaSeguimientoNuevos>>(
        future: _providerGuias.getListaSeguimientoNuevo(''),
        builder: (BuildContext context,
            AsyncSnapshot<List<ListaSeguimientoNuevos>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.hasData == false) {
              return Center(
                child: Text("¡No existen registros"),
              );
            } else {
              final listaPersonalAux = snapshot.data;

              if (listaPersonalAux.length == 0) {
                return Center(
                  child: Text("No hay informacion"),
                );
              } else {
                return Container(
                  child: RefreshIndicator(
                      child: ListView.builder(
                        itemCount: listaPersonalAux.length,
                        itemBuilder: (context, i) =>
                            _banTitle(listaPersonalAux[i]),
                      ),
                      onRefresh: refreshList),
                );
              }
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget buildSwipeActionLeft() => Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.green,
      child: Icon(
        Icons.print,
        color: Colors.white,
        size: 32,
      ));
  Widget buildSwipeActionRigth() => Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.orange,
      child: Icon(
        Icons.mail,
        color: Colors.white,
        size: 32,
      ));
  ListTile _banTitle(ListaSeguimientoNuevos band) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(band.cuenta.substring(0, 2)),
        //${band.origen.substring(0, 1)}
        backgroundColor: Colors.blue[900],
      ),
      title: Text('${band.numero_guia}', style: TextStyle(fontSize: 13)),
      subtitle: new Text('${band.remitente}', style: TextStyle(fontSize: 10)),

      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70,
            child: Text(
              ' ${band.fecha_traslado}',
              style: TextStyle(fontSize: 10),
            ),
          ),
          Container(
            width: 100,
            child: Text(
              '${band.nombre_provincia} ',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ],
      ),
      //EDITAR CON PUSH AL REGISTRO, SE VA AL EDITAR, UNA NUEVA PANTALLA
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => EditarSeguimientoNuevoPage(
                    idGuiaRem: band.id_guia_remision,
                    //tipo: band.tipo,
                  )),
        );
      },
    );
  }

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
}

///////
////////
///////
////////
///
///
///

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
      await Future.delayed(Duration(seconds: 5));
      _providerLista.getListaSeguimientoNuevo('');
    }

    ListTile _banTitle(ListaSeguimientoNuevos band) {
      return ListTile(
        leading: CircleAvatar(
          child: Text(band.cuenta.substring(0, 2)),
          //${band.origen.substring(0, 1)}
          backgroundColor: Colors.blue[900],
        ),
        title: Text('${band.numero_guia}', style: TextStyle(fontSize: 13)),
        subtitle: new Text('${band.direccion}', style: TextStyle(fontSize: 10)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              child: Text(
                ' ${band.fecha_traslado}',
                style: TextStyle(fontSize: 10),
              ),
            ),
            Container(
              width: 100,
              child: Text(
                '${band.nombre_provincia} ',
                style: TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
        //EDITAR CON PUSH AL REGISTRO, SE VA AL EDITAR, UNA NUEVA PANTALLA
        onTap: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => EditarSeguimientoNuevoPage(
                      idGuiaRem: band.id_guia_remision,

                      ///tipo: band.tipo,
                    )),
          );
        },
      );
    }

    if (query.trim().length == 0) {
      return Text('no hay valor');
    }

    return FutureBuilder<List<ListaSeguimientoNuevos>>(
      future: _providerLista.getListaSeguimientoNuevo(query),
      builder: (BuildContext context,
          AsyncSnapshot<List<ListaSeguimientoNuevos>> snapshot) {
        if (snapshot.hasData) {
          final listaPersonalAux = snapshot.data;
          return Container(
            child: RefreshIndicator(
                child: ListView.builder(
                  itemCount: listaPersonalAux.length,
                  itemBuilder: (context, i) => _banTitle(listaPersonalAux[i]),
                ),
                onRefresh: refreshList),
          );
          ;
        }
        return SizedBox();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Future<Null> refreshList() async {
      await Future.delayed(Duration(seconds: 5));
      _providerLista.getListaSeguimientoNuevo('');
    }

    ListTile _banTitle(ListaSeguimientoNuevos band) {
      return ListTile(
        leading: CircleAvatar(
          child: Text(band.cuenta.substring(0, 2)),
          //${band.origen.substring(0, 1)}
          backgroundColor: Colors.blue[900],
        ),
        title: Text('${band.numero_guia}', style: TextStyle(fontSize: 13)),
        subtitle: new Text('${band.direccion}', style: TextStyle(fontSize: 10)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              child: Text(
                ' ${band.fecha_traslado}',
                style: TextStyle(fontSize: 10),
              ),
            ),
            Container(
              width: 100,
              child: Text(
                '${band.nombre_provincia} ',
                style: TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
        //EDITAR CON PUSH AL REGISTRO, SE VA AL EDITAR, UNA NUEVA PANTALLA
        onTap: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => EditarSeguimientoNuevoPage(
                      idGuiaRem: band.id_guia_remision,
                      //tipo: band.tipo,
                    )),
          );
        },
      );
    }

    return FutureBuilder<List<ListaSeguimientoNuevos>>(
      future: _providerLista.getListaSeguimientoNuevo(query),
      builder: (BuildContext context,
          AsyncSnapshot<List<ListaSeguimientoNuevos>> snapshot) {
        if (snapshot.hasData) {
          final listaPersonalAux = snapshot.data;
          return Container(
            child: RefreshIndicator(
                child: ListView.builder(
                  itemCount: listaPersonalAux.length,
                  itemBuilder: (context, i) => _banTitle(listaPersonalAux[i]),
                ),
                onRefresh: refreshList),
          );
        }
        return SizedBox();
      },
    );
  }
}
