import 'package:Pegaso/src/data/models/TipoDocumento.dart';
import 'package:Pegaso/src/data/models/entidades.dart';
import 'package:Pegaso/src/data/provider/providerEntidades.dart';
import 'package:Pegaso/src/pages/Entidades/CrearEntidad.dart';
import 'package:Pegaso/src/pages/Entidades/EditarEntidad.dart';
import 'package:flutter/material.dart';

class EntidadesPage extends StatefulWidget {
  const EntidadesPage({Key key}) : super(key: key);

  @override
  State<EntidadesPage> createState() => _EntidadesPageState();
}

class _EntidadesPageState extends State<EntidadesPage> {
  final _provider = new ProviderEntidades();
  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 5));
    _provider.getEntidades('');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange[600],
        onPressed: () async {
          final respuesta = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CrearEntidad()),
          );

          if (respuesta == 'OK') {
            refreshList();
            setState(() {});
          } else {}
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("CLIENTES"),
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
      ),
      body: FutureBuilder<List<Entidad>>(
        future: _provider.getEntidadesS(query: ''),
        builder: (BuildContext context, AsyncSnapshot<List<Entidad>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.hasData == false) {
              return Center(
                child: Text("¡No existen registros!"),
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
                          itemBuilder: (context, i) {
                            return Dismissible(
                                key: UniqueKey(),
                                onDismissed: (direction) async {
                                  var nmSolicitud, cliente, idAtencionPedidos;
                                  switch (direction) {
                                    case DismissDirection.endToStart:
                                      break;
                                    case DismissDirection.startToEnd:
                                      print("object");
                                      _provider.delete(listaPersonalAux[0]);
                                      refreshList();
                                      break;
                                  }

                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                          "Eliminado ${listaPersonalAux[0].razon_social}")));
                                },
                                background: buildSwipeActionLeft(),
                                // secondaryBackground: buildSwipeActionRigth(),
                                child: _banTitle(listaPersonalAux[i]));
                          },
                        ),
                        onRefresh: refreshList));
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

  ListTile _banTitle(Entidad band) {
    return ListTile(
      // focusColor: Colors.black,
      //tileColor:Colors.red ,
      //hoverColor: Colors.blue,
      leading: CircleAvatar(
        child: Text(band.razon_social.substring(0, 2)),
        backgroundColor: Colors.blue[900],
      ),
      title: Text(band.razon_social, style: TextStyle(fontSize: 12)),
      subtitle: new Text(band.numero_documento, style: TextStyle(fontSize: 13)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: TextDirection.rtl,
        children: [
          /*   Text(
            '${band.}',
            style: TextStyle(fontSize: 10),
          ),
          Text(
            '${band.nombreDistrito}',
            style: TextStyle(fontSize: 10),
          ), */
        ],
      ),
      onTap: () async {
        //   await DatabasePr.db.eliminarTodo();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditarEntidad(entidad: band)),
        );
        /**/
      },
    );
  }

  Widget buildSwipeActionLeft() => Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
        size: 32,
      ));
}

class CustomSearchDelegate extends SearchDelegate {
  final _provider = new ProviderEntidades();
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

  Widget buildSwipeActionLeft() => Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
        size: 32,
      ));
  @override
  Widget buildResults(BuildContext context) {
    Future<Null> refreshList() async {
      await Future.delayed(Duration(seconds: 1));
      _provider.getEntidadesS();
    }

    if (query.trim().length == 0) {
      return Text('no hay valor');
    }

    ListTile _banTitle(Entidad band) {
      return ListTile(
        leading: CircleAvatar(
          child: Text(band.razon_social.substring(0, 2)),
          backgroundColor: Colors.blue[900],
        ),
        title: Text(band.razon_social, style: TextStyle(fontSize: 12)),
        subtitle:
            new Text(band.numero_documento, style: TextStyle(fontSize: 13)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: [],
        ),
        onTap: () async {
          //   await DatabasePr.db.eliminarTodo();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditarEntidad(entidad: band)),
          );
          /**/
        },
      );
    }

    if (query.trim().length == 0) {
      return Text('no hay valor');
    }

    return FutureBuilder<List<Entidad>>(
      future: _provider.getEntidadesS(query: query),
      builder: (BuildContext context, AsyncSnapshot<List<Entidad>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.hasData == false) {
            return Center(
              child: Text("¡No existen registros"),
            );
          } else {
            final listaPersonalAux = snapshot.data;
            if (listaPersonalAux?.length == 0) {
              return Center(
                child: Text("No hay informacion"),
              );
            } else {
              return Container(
                  child: RefreshIndicator(
                      child: ListView.builder(
                        itemCount: listaPersonalAux.length,
                        itemBuilder: (context, i) {
                          return Dismissible(
                              key: UniqueKey(),
                              onDismissed: (direction) async {
                                var nmSolicitud, cliente, idAtencionPedidos;
                                switch (direction) {
                                  case DismissDirection.endToStart:
                                    break;
                                  case DismissDirection.startToEnd:
                                    _provider.delete(listaPersonalAux[0]);
                                    refreshList();
                                    break;
                                }

                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "Eliminado ${listaPersonalAux[0].razon_social}")));
                              },
                              background: buildSwipeActionLeft(),
                              // secondaryBackground: buildSwipeActionRigth(),
                              child: _banTitle(listaPersonalAux[i]));
                        },
                      ),
                      onRefresh: refreshList));
            }
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
      _provider.getEntidadesS();
    }

    ListTile _banTitle(Entidad band) {
      return ListTile(
        leading: CircleAvatar(
          child: Text(band.razon_social.substring(0, 2)),
          backgroundColor: Colors.blue[900],
        ),
        title: Text(band.razon_social, style: TextStyle(fontSize: 12)),
        subtitle:
            new Text(band.numero_documento, style: TextStyle(fontSize: 13)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: [],
        ),
        onTap: () async {
          //   await DatabasePr.db.eliminarTodo();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditarEntidad(entidad: band)),
          );
          /**/
        },
      );
    }

    return FutureBuilder<List<Entidad>>(
      future: _provider.getEntidadesS(query: query),
      builder: (BuildContext context, AsyncSnapshot<List<Entidad>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.hasData == false) {
            return Center(
              child: Text("¡No existen registros"),
            );
          } else {
            final listaPersonalAux = snapshot.data;
            if (listaPersonalAux?.length == 0) {
              return Center(
                child: Text("No hay informacion"),
              );
            } else {
              return Container(
                  child: RefreshIndicator(
                      child: ListView.builder(
                        itemCount: listaPersonalAux.length,
                        itemBuilder: (context, i) {
                          return Dismissible(
                              key: UniqueKey(),
                              onDismissed: (direction) async {
                                var nmSolicitud, cliente, idAtencionPedidos;
                                switch (direction) {
                                  case DismissDirection.endToStart:
                                    break;
                                  case DismissDirection.startToEnd:
                                    print("object");
                                    _provider.delete(listaPersonalAux[0]);
                                    refreshList();
                                    break;
                                }

                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "Eliminado ${listaPersonalAux[0].razon_social}")));
                              },
                              background: buildSwipeActionLeft(),
                              // secondaryBackground: buildSwipeActionRigth(),
                              child: _banTitle(listaPersonalAux[i]));
                        },
                      ),
                      onRefresh: refreshList));
            }
          }
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
