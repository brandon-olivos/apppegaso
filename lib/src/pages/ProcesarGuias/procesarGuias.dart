import 'dart:async';

import 'package:Pegaso/src/Pages/Asignaciones/atendender_asignacion.dart';
import 'package:Pegaso/src/data/Print/imprimir_home.dart';
import 'package:Pegaso/src/data/models/guia_rem_cliente_m.dart';
import 'package:Pegaso/src/data/models/listaGuiasPend.dart';
import 'package:Pegaso/src/data/provider/ProviderAsignacion.dart';
import 'package:Pegaso/src/data/provider/ProviderGuias.dart';
import 'package:Pegaso/src/data/provider/providerProcesarGuias.dart';
import 'package:Pegaso/src/pages/ProcesarGuias/guiaRemisionP.dart';

import 'package:flutter/material.dart';
import 'package:Pegaso/src/data/models/listaAsignacion.dart';

// ignore: must_be_immutable
class ProcesarGuias extends StatefulWidget {
  String titulo;

  ProcesarGuias({this.titulo});

  @override
  _ProcesarGuiasPageState createState() => _ProcesarGuiasPageState();
}

class _ProcesarGuiasPageState extends State<ProcesarGuias> {
  final _providerGuias = new ProviderProcesarGuias();

  @override
  void initState() {
    super.initState();
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 10));
    _providerGuias.getListaGuiasPend('');
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
        title: Text(
          '${widget.titulo}',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 1,
      ),
      body: FutureBuilder<List<ListaGuiasPend>>(
        future: _providerGuias.getListaGuiasPend(''),
        builder: (BuildContext context,
            AsyncSnapshot<List<ListaGuiasPend>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.hasData == false) {
              return Center(
                child: Text("¡No existen registros"),
              );
            } else {
              final listaPersonalAux = snapshot.data;
              return Container(
                child: RefreshIndicator(
                    child: ListView.builder(
                      itemCount: listaPersonalAux.length,
                      itemBuilder: (context, i) {
                        return Dismissible(

                            //direction: DismissDirection.,
                            key: Key(listaPersonalAux[i].idGuiaRemision),
                            onDismissed: (direction) async {
                              var nmSolicitud,
                                  cliente,
                                  idGuiaRemision,
                                  ideliminado = 0;
                              switch (direction) {
                                case DismissDirection.endToStart:
                                  idGuiaRemision =
                                      listaPersonalAux[i].idGuiaRemision;
                                  nmSolicitud = listaPersonalAux[i].nmSolicitud;

                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Eliminar'),
                                      content: const Text(
                                          'Desea Eliminar esta Guia'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  unawaited(
                                                      _providerGuias.Delete(
                                                          idGuiaRemision));
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Si'),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('No'),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                  break;
                              }
                              setState(() {
                                listaPersonalAux.removeAt(i);
                                print(direction.index);
                              });

                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text("$nmSolicitud")));
                            },

                            // Muestra un background rojo a medida que el elemento se elimina
                            background: buildSwipeActionLeft(),
                            secondaryBackground: buildSwipeActionRigth(),
                            child: _banTitle(listaPersonalAux[i]));
                      },
                      /* itemBuilder: (context, i) =>
                        _banTitle(listaPersonalAux[i])*/
                    ),
                    onRefresh: refreshList),
              );
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
        Icons.payments_rounded,
        color: Colors.white,
        size: 32,
      ));

  Widget buildSwipeActionRigth() => Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
        size: 32,
      ));

  ListTile _banTitle(ListaGuiasPend band) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(band.destinatario.substring(0, 2)),
        backgroundColor: Colors.blue[900],
      ),
      title: Text(band.nmSolicitud, style: TextStyle(fontSize: 13)),
      subtitle: new Text(band.destinatario, style: TextStyle(fontSize: 10)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            ' ${band.destino}',
            style: TextStyle(fontSize: 13),
          ),
          Text(
            '${band.fecha} ',
            style: TextStyle(fontSize: 10),
          )
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GuiaRemisionP(
                    guiapen: band,
                  )),
        );
      },
    );
  }

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
}

class CustomSearchDelegate extends SearchDelegate {
  final _providerLista = new ProviderProcesarGuias();

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
      _providerLista.getListaGuiasPend('');
    }

    ListTile _banTitle(ListaGuiasPend band) {
      return ListTile(
        leading: CircleAvatar(
          child: Text(band.destinatario.substring(0, 2)),
          backgroundColor: Colors.blue[900],
        ),
        title: Text(band.nmSolicitud, style: TextStyle(fontSize: 13)),
        subtitle: new Text(band.destinatario, style: TextStyle(fontSize: 10)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ' ${band.destino}',
              style: TextStyle(fontSize: 13),
            ),
            Text(
              '${band.fecha} ',
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GuiaRemisionP(
                      guiapen: band,
                    )),
          );
        },
      );
    }

    if (query.trim().length == 0) {
      return Text('no hay valor');
    }

    return FutureBuilder<List<ListaGuiasPend>>(
      future: _providerLista.getListaGuiasPend(query),
      builder:
          (BuildContext context, AsyncSnapshot<List<ListaGuiasPend>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.hasData == false) {
            return Center(
              child: Text("¡No existen registros"),
            );
          } else {
            var listaPersonalAux = snapshot.data;
            return Container(
              child: RefreshIndicator(
                  child: ListView.builder(
                    itemCount: listaPersonalAux.length,
                    itemBuilder: (context, i) => _banTitle(listaPersonalAux[i]),
                  ),
                  onRefresh: refreshList),
            );
          }
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Future<Null> refreshList() async {
      await Future.delayed(Duration(seconds: 1));
      _providerLista.getListaGuiasPend('');
    }

    refreshList();
    ListTile _banTitle(ListaGuiasPend band) {
      return ListTile(
        leading: CircleAvatar(
          child: Text(band.destinatario.substring(0, 2)),
          backgroundColor: Colors.blue[900],
        ),
        title: Text(band.nmSolicitud, style: TextStyle(fontSize: 13)),
        subtitle: new Text(band.destinatario, style: TextStyle(fontSize: 10)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ' ${band.destino}',
              style: TextStyle(fontSize: 13),
            ),
            Text(
              '${band.fecha} ',
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GuiaRemisionP(
                      guiapen: band,
                    )),
          );
        },
      );
    }

    return FutureBuilder<List<ListaGuiasPend>>(
      future: _providerLista.getListaGuiasPend(query),
      builder:
          (BuildContext context, AsyncSnapshot<List<ListaGuiasPend>> snapshot) {
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
}
