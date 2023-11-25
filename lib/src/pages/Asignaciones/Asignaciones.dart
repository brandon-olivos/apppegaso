import 'package:Pegaso/src/Pages/Asignaciones/atendender_asignacion.dart';
import 'package:Pegaso/src/data/Print/imprimir_home.dart';
import 'package:Pegaso/src/data/db/token.dart';
import 'package:Pegaso/src/data/provider/ProviderAsignacion.dart';

import 'package:flutter/material.dart';
import 'package:Pegaso/src/data/models/listaAsignacion.dart';

// ignore: must_be_immutable
class AsignacionesPage extends StatefulWidget {
  String titulo;

  AsignacionesPage({this.titulo});

  @override
  _AsignacionesPageState createState() => _AsignacionesPageState();
}

class _AsignacionesPageState extends State<AsignacionesPage> {
  final _providerAsignacion = new ProviderAsignacion();

  @override
  void initState() {
    super.initState();
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 10));
    _providerAsignacion.getListaAsignaciones('');
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
        body: FutureBuilder<List<ListaAsignacion>>(
          future: _providerAsignacion.getListaAsignaciones(''),
          builder: (BuildContext context,
              AsyncSnapshot<List<ListaAsignacion>> snapshot) {
            if (snapshot.hasData) {
              final listaPersonalAux = snapshot.data;
              return Container(
                  child: RefreshIndicator(
                      child: ListView.builder(
                        itemCount: listaPersonalAux.length,
                        itemBuilder: (context, i) {
                          return Dismissible(
                              key: Key(listaPersonalAux[i].id.toString()),
                              onDismissed: (direction) async {
                                var nmSolicitud, cliente, idAtencionPedidos;
                                switch (direction) {
                                  case DismissDirection.endToStart:
                                    idAtencionPedidos = listaPersonalAux[i].id;
                                    nmSolicitud = listaPersonalAux[i].solicitud;
                                    await _providerAsignacion.getMailCerrar(
                                        nmSolicitud, idAtencionPedidos);

                                    break;
                                  case DismissDirection.startToEnd:
                                    setState(() {
                                      cliente = listaPersonalAux[i].entidad;
                                      nmSolicitud =
                                          listaPersonalAux[i].solicitud;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ImprimirHome(
                                                  solicitud: nmSolicitud,
                                                  cliente: cliente,
                                                )),
                                      );
                                    });
                                }

                                setState(() {
                                  listaPersonalAux.removeAt(i);
                                });

                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text("$cliente")));
                              },

                              // Muestra un background rojo a medida que el elemento se elimina
                              background: buildSwipeActionLeft(),
                              secondaryBackground: buildSwipeActionRigth(),
                              child: _banTitle(listaPersonalAux[i]));
                        },
                      ),
                      onRefresh: refreshList));
            }
            return SizedBox();
          },
        ));
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

  ListTile _banTitle(ListaAsignacion band) {
    return ListTile(
      // focusColor: Colors.black,
      //tileColor:Colors.red ,
      //hoverColor: Colors.blue,
      leading: CircleAvatar(
        child: Text(band.entidad.substring(0, 2)),
        backgroundColor: Colors.blue[900],
      ),
      title: Text(band.entidad, style: TextStyle(fontSize: 12)),
      subtitle: new Text(band.solicitud, style: TextStyle(fontSize: 13)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: TextDirection.rtl,
        children: [
          Text(
            '${band.fecha} ${band.hora}',
            style: TextStyle(fontSize: 10),
          ),
          Text(
            '${band.contacto}',
            style: TextStyle(fontSize: 10),
          ),
          Text(
            '${band.telefono}',
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
      onTap: () async {
        await DatabasePr.db.eliminarTodo();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AtendenderAsignacion(
                    solicitud: band.solicitud,
                    id: band.id,
                    fecha: band.fecha,
                    destinatario: band.destinatario,
                    idDestinatario: band.id_destinatario,
                    direccionLlegada: band.direccion_llegada,
                    idDireccionDestino: band.id_direccion_destino,
                  )),
        );
      },
    );
  }

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
}

class CustomSearchDelegate extends SearchDelegate {
  final _providerLista = new ProviderAsignacion();

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
      _providerLista.getListaAsignaciones('');
    }

    ListTile _banTitle(ListaAsignacion band) {
      return ListTile(
        leading: CircleAvatar(
          child: Text(band.entidad.substring(0, 2)),
          backgroundColor: Colors.blue[900],
        ),
        title: Text(band.entidad, style: TextStyle(fontSize: 12)),
        subtitle: new Text(band.solicitud, style: TextStyle(fontSize: 13)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: [
            Text(
              '${band.fecha} ${band.hora}',
              style: TextStyle(fontSize: 10),
            ),
            Text(
              '${band.contacto}',
              style: TextStyle(fontSize: 10),
            ),
            Text(
              '${band.telefono}',
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AtendenderAsignacion(
                      solicitud: band.solicitud,
                      id: band.id,
                      fecha: band.fecha,
                    )),
          );
        },
      );
    }

    if (query.trim().length == 0) {
      return Text('no hay valor');
    }

    return FutureBuilder<List<ListaAsignacion>>(
      future: _providerLista.getListaAsignaciones(query),
      builder: (BuildContext context,
          AsyncSnapshot<List<ListaAsignacion>> snapshot) {
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
      _providerLista.getListaAsignaciones('');
    }

    ListTile _banTitle(ListaAsignacion band) {
      return ListTile(
        leading: CircleAvatar(
          child: Text(band.entidad.substring(0, 2)),
          backgroundColor: Colors.blue[900],
        ),
        title: Text(band.entidad, style: TextStyle(fontSize: 12)),
        subtitle: new Text(band.solicitud, style: TextStyle(fontSize: 13)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: [
            Text(
              '${band.fecha} ${band.hora}',
              style: TextStyle(fontSize: 10),
            ),
            Text(
              '${band.contacto}',
              style: TextStyle(fontSize: 10),
            ),
            Text(
              '${band.telefono}',
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
        onTap: () async {
          await DatabasePr.db.eliminarTodo();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AtendenderAsignacion(
                      solicitud: band.solicitud,
                      id: band.id,
                      fecha: band.fecha,
                    )),
          );
        },
      );
    }

    return FutureBuilder<List<ListaAsignacion>>(
      future: _providerLista.getListaAsignaciones(query),
      builder: (BuildContext context,
          AsyncSnapshot<List<ListaAsignacion>> snapshot) {
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
