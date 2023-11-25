import 'package:Pegaso/src/data/db/token.dart';
import 'package:Pegaso/src/data/models/listaDirecciones.dart';
import 'package:Pegaso/src/data/provider/provider.dart';
import 'package:Pegaso/src/pages/Direcciones/EditarDirecciones.dart';
import 'package:Pegaso/src/pages/Direcciones/RegDirecciones.dart';
import 'package:flutter/material.dart';

class DireccionesPage extends StatefulWidget {
  @override
  State<DireccionesPage> createState() => _DireccionesPageState();
}

class _DireccionesPageState extends State<DireccionesPage> {
  final _provider = new Provider();
  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 5));
    _provider.getListaDirecciones('');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DIRECCIONES CLIENTES"),
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
      body: FutureBuilder<List<ListaDirecciones>>(
        future: _provider.getListaDirecciones(''),
        builder: (BuildContext context,
            AsyncSnapshot<List<ListaDirecciones>> snapshot) {
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
                                key: Key(listaPersonalAux[i].idDireccion),
                                onDismissed: (direction) async {
                                  var nmSolicitud, cliente, idAtencionPedidos;
                                  switch (direction) {
                                    case DismissDirection.endToStart:
                                      break;
                                    case DismissDirection.startToEnd:
                                  }

                                  Scaffold.of(context).showSnackBar(
                                      SnackBar(content: Text("$cliente")));
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange[600],
        onPressed: () async {
          final respuesta = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegDireccionesPage()),
          );

          if (respuesta == 'OK') {
            refreshList();
            setState(() {});
          } else {}
        },
        child: Icon(Icons.add),
      ),
    );
  }

  ListTile _banTitle(ListaDirecciones band) {
    return ListTile(
      // focusColor: Colors.black,
      //tileColor:Colors.red ,
      //hoverColor: Colors.blue,
      leading: CircleAvatar(
        child: Text(band.entidad.substring(0, 2)),
        backgroundColor: Colors.blue[900],
      ),
      title: Text(band.entidad, style: TextStyle(fontSize: 12)),
      subtitle: new Text(band.direccion, style: TextStyle(fontSize: 13)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: TextDirection.rtl,
        children: [
          Text(
            '${band.nombreProvincia}',
            style: TextStyle(fontSize: 10),
          ),
          Text(
            '${band.nombreDistrito}',
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
      onTap: () async {
        //   await DatabasePr.db.eliminarTodo();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditDireccionesPage(band)),
        );
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
  final _provider = new Provider();
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

      _provider.getListaDirecciones('');
    }

    if (query.trim().length == 0) {
      return Text('no hay valor');
    }

    ListTile _banTitle(ListaDirecciones band) {
      return ListTile(
        // focusColor: Colors.black,
        //tileColor:Colors.red ,
        //hoverColor: Colors.blue,
        leading: CircleAvatar(
          child: Text(band.entidad.substring(0, 2)),
          backgroundColor: Colors.blue[900],
        ),
        title: Text(band.entidad, style: TextStyle(fontSize: 12)),
        subtitle: new Text(band.direccion, style: TextStyle(fontSize: 13)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: [
            Text(
              '${band.nombreProvincia}',
              style: TextStyle(fontSize: 10),
            ),
            Text(
              '${band.nombreDistrito}',
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
        onTap: () async {
          //   await DatabasePr.db.eliminarTodo();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditDireccionesPage(band)),
          );
        },
      );
    }

    if (query.trim().length == 0) {
      return Text('no hay valor');
    }

    return FutureBuilder<List<ListaDirecciones>>(
      future: _provider.getListaDirecciones(query),
      builder: (BuildContext context,
          AsyncSnapshot<List<ListaDirecciones>> snapshot) {
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
                              key: Key(listaPersonalAux[i].idDireccion),
                              onDismissed: (direction) async {
                                var nmSolicitud, cliente, idAtencionPedidos;
                                switch (direction) {
                                  case DismissDirection.endToStart:
                                    break;
                                  case DismissDirection.startToEnd:
                                }

                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text("$cliente")));
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
  Widget buildSuggestions(BuildContext context) {
    Future<Null> refreshList() async {
      await Future.delayed(Duration(seconds: 1));
      _provider.getListaDirecciones('');
    }

    ListTile _banTitle(ListaDirecciones band) {
      return ListTile(
        // focusColor: Colors.black,
        //tileColor:Colors.red ,
        //hoverColor: Colors.blue,
        leading: CircleAvatar(
          child: Text(band.entidad.substring(0, 2)),
          backgroundColor: Colors.blue[900],
        ),
        title: Text(band.entidad, style: TextStyle(fontSize: 12)),
        subtitle: new Text(band.direccion, style: TextStyle(fontSize: 13)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: [
            Text(
              '${band.nombreProvincia}',
              style: TextStyle(fontSize: 10),
            ),
            Text(
              '${band.nombreDistrito}',
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
        onTap: () async {
          //   await DatabasePr.db.eliminarTodo();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditDireccionesPage(band)),
          );
        },
      );
    }

    return FutureBuilder<List<ListaDirecciones>>(
      future: _provider.getListaDirecciones(query),
      builder: (BuildContext context,
          AsyncSnapshot<List<ListaDirecciones>> snapshot) {
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
                              key: Key(listaPersonalAux[i].idDireccion),
                              onDismissed: (direction) async {
                                var nmSolicitud, cliente, idAtencionPedidos;
                                switch (direction) {
                                  case DismissDirection.endToStart:
                                    break;
                                  case DismissDirection.startToEnd:
                                }

                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text("$cliente")));
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
