import 'package:Pegaso/src/Pages/GuiaRemAuxiliar/Actions/CrearGuiaRem.dart';
import 'package:Pegaso/src/Pages/GuiaRemAuxiliar/Actions/editarGuiaCliente.dart';
import 'package:Pegaso/src/data/models/listaGuiasRem.dart';
import 'package:Pegaso/src/data/provider/ProviderGuiasAuxiliar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListaGuiaRemAuxiliar extends StatefulWidget {
  String titulo;

  ListaGuiaRemAuxiliar({this.titulo});
  @override
  _GuiaRemAuxiliarPageState createState() => _GuiaRemAuxiliarPageState();
}

class _GuiaRemAuxiliarPageState extends State<ListaGuiaRemAuxiliar> {
  final _providerGuias = new ProviderGuiasAuxiliar();

  @override
  void initState() {
    super.initState();
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 10));
    _providerGuias.getListaGuiasAuxiliar('');
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
            icon: Icon(Icons.add_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CrearGuiaRemAuxiliarPage()),
              );
            },
          ),
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
      body: FutureBuilder<List<ListaGuiasRem>>(
        future: _providerGuias.getListaGuiasAuxiliar(''),
        builder: (BuildContext context,
            AsyncSnapshot<List<ListaGuiasRem>> snapshot) {
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
  ListTile _banTitle(ListaGuiasRem band) {
    return ListTile(
      leading: CircleAvatar(
        child: Text('GR'),
        //${band.origen.substring(0, 1)}
        backgroundColor: Colors.blue[900],
      ),
      title: Text('${band.numero_guia}', style: TextStyle(fontSize: 13)),
      subtitle:
          new Text('${band.destinatario}', style: TextStyle(fontSize: 10)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70,
            child: Text(
              ' ${band.destino}',
              style: TextStyle(fontSize: 9),
            ),
          ),
          Container(
            width: 70,
            child: Text(
              '${band.fecha} ',
              style: TextStyle(fontSize: 10),
            ),
          ),
          Text(
            ' ${band.nmSolicitud}',
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
      onTap: () {
        print('${band.idGuiaRemision}');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditarGuiaRemAuxiliarPage(
                  guiRempegaso: int.parse(band.idGuiaRemision))),
        );
      },
    );
  }

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
}

class CustomSearchDelegate extends SearchDelegate {
  final _providerLista = new ProviderGuiasAuxiliar();
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
      _providerLista.getListaGuiasAuxiliar('');
    }

    ListTile _banTitle(ListaGuiasRem band) {
      return ListTile(
        leading: CircleAvatar(
          child: Text('GR'),
          //band.destinatario.substring(0, 2)
          backgroundColor: Colors.blue[900],
        ),
        title: Text('${band.numero_guia}', style: TextStyle(fontSize: 13)),
        subtitle:
            new Text('${band.destinatario}', style: TextStyle(fontSize: 10)),
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
          print('hola');
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditarGuiaRemAuxiliarPage(
                    guiRempegaso: int.parse(band.idGuiaRemision))),
          );
        },
      );
    }

    if (query.trim().length == 0) {
      return Text('no hay valor');
    }

    return FutureBuilder<List<ListaGuiasRem>>(
      future: _providerLista.getListaGuiasAuxiliar(query),
      builder:
          (BuildContext context, AsyncSnapshot<List<ListaGuiasRem>> snapshot) {
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
    Future<Null> refreshList() async {
      await Future.delayed(Duration(seconds: 1));
      _providerLista.getListaGuiasAuxiliar('');
    }

    ListTile _banTitle(ListaGuiasRem band) {
      return ListTile(
        leading: CircleAvatar(
          child: Text('GR'),
          backgroundColor: Colors.blue[900],
        ),
        title: Text('${band.numero_guia}', style: TextStyle(fontSize: 13)),
        subtitle:
            new Text('${band.destinatario}', style: TextStyle(fontSize: 10)),
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
          print('hola');
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditarGuiaRemAuxiliarPage(
                    guiRempegaso: int.parse(band.idGuiaRemision))),
          );
        },
      );
    }

    return FutureBuilder<List<ListaGuiasRem>>(
      future: _providerLista.getListaGuiasAuxiliar(query),
      builder:
          (BuildContext context, AsyncSnapshot<List<ListaGuiasRem>> snapshot) {
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
}
