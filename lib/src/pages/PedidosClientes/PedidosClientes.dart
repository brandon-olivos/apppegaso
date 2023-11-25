import 'package:Pegaso/src/data/models/ListaPedidosClientes.dart';
import 'package:Pegaso/src/data/provider/providerListaPedidosClientes.dart';
import 'package:Pegaso/src/pages/PedidosClientes/EditarPedidoCliente.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PedidosClientes extends StatefulWidget {
  String titulo;

  PedidosClientes({this.titulo});
  @override
  _PedidosClientesState createState() => _PedidosClientesState();
}

class _PedidosClientesState extends State<PedidosClientes> {
  final _providerGuias = new ProviderListaPedidosClientes();

  @override
  void initState() {
    super.initState();
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 10));
    _providerGuias.getListaPedidosClientes('');
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
      body: FutureBuilder<List<ListaPedidosClientes>>(
        future: _providerGuias.getListaPedidosClientes(''),
        builder: (BuildContext context,
            AsyncSnapshot<List<ListaPedidosClientes>> snapshot) {
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
  ListTile _banTitle(ListaPedidosClientes band) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(band.nombre_estado.substring(0, 2)),
        //${band.origen.substring(0, 1)}
        backgroundColor: Colors.blue[900],
      ),
      title: Text('${band.nm_solicitud}', style: TextStyle(fontSize: 13)),
      subtitle:
          new Text('${band.tipo_servicios}', style: TextStyle(fontSize: 10)),

      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70,
            child: Text(
              ' ${band.nombre_estado}',
              style: TextStyle(fontSize: 10),
            ),
          ),
          Container(
            width: 100,
            child: Text(
              '${band.hora_recojo}   ${band.fecha}',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ],
      ),
      //EDITAR CON PUSH AL REGISTRO, SE VA AL EDITAR, UNA NUEVA PANTALLA
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => EditarPedidoClientePage(
                    idPedidoCliente: band.id_pedido_cliente,
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
  final _providerLista = new ProviderListaPedidosClientes();

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
      _providerLista.getListaPedidosClientes('');
    }

    ListTile _banTitle(ListaPedidosClientes band) {
      return ListTile(
        leading: CircleAvatar(
          child: Text(band.nombre_estado.substring(0, 2)),
          //${band.origen.substring(0, 1)}
          backgroundColor: Colors.blue[900],
        ),
        title: Text('${band.nm_solicitud}', style: TextStyle(fontSize: 13)),
        subtitle:
            new Text('${band.tipo_servicios}', style: TextStyle(fontSize: 10)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              child: Text(
                ' ${band.nombre_estado}',
                style: TextStyle(fontSize: 10),
              ),
            ),
            Container(
              width: 100,
              child: Text(
                '${band.hora_recojo}   ${band.fecha}',
                style: TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
        //EDITAR CON PUSH AL REGISTRO, SE VA AL EDITAR, UNA NUEVA PANTALLA
        onTap: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => EditarPedidoClientePage(
                      idPedidoCliente: band.id_pedido_cliente,

                      ///tipo: band.tipo,
                    )),
          );
        },
      );
    }

    if (query.trim().length == 0) {
      return Text('no hay valor');
    }

    return FutureBuilder<List<ListaPedidosClientes>>(
      future: _providerLista.getListaPedidosClientes(query),
      builder: (BuildContext context,
          AsyncSnapshot<List<ListaPedidosClientes>> snapshot) {
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
      _providerLista.getListaPedidosClientes('');
    }

    ListTile _banTitle(ListaPedidosClientes band) {
      return ListTile(
        leading: CircleAvatar(
          child: Text(band.nombre_estado.substring(0, 2)),
          //${band.origen.substring(0, 1)}
          backgroundColor: Colors.blue[900],
        ),
        title: Text('${band.nm_solicitud}', style: TextStyle(fontSize: 13)),
        subtitle:
            new Text('${band.tipo_servicios}', style: TextStyle(fontSize: 10)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              child: Text(
                ' ${band.nombre_estado}',
                style: TextStyle(fontSize: 10),
              ),
            ),
            Container(
              width: 100,
              child: Text(
                '${band.hora_recojo}   ${band.fecha}',
                style: TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
        //EDITAR CON PUSH AL REGISTRO, SE VA AL EDITAR, UNA NUEVA PANTALLA
        onTap: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => EditarPedidoClientePage(
                      idPedidoCliente: band.id_pedido_cliente,
                      //tipo: band.tipo,
                    )),
          );
        },
      );
    }

    return FutureBuilder<List<ListaPedidosClientes>>(
      future: _providerLista.getListaPedidosClientes(query),
      builder: (BuildContext context,
          AsyncSnapshot<List<ListaPedidosClientes>> snapshot) {
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
