import 'package:Pegaso/src/data/models/ListaPedidoClienteOp.dart';
import 'package:Pegaso/src/data/provider/ProviderPedidoClienteOp.dart';
import 'package:Pegaso/src/pages/PedidosOperaciones/CrearPedidosOperaciones.dart';
import 'package:Pegaso/src/pages/PedidosOperaciones/EditarPedidos.dart';
import 'package:flutter/material.dart';

class PedidosOperacionesPage extends StatefulWidget {
  @override
  State<PedidosOperacionesPage> createState() => _PedidosOperacionesPageState();
}

class _PedidosOperacionesPageState extends State<PedidosOperacionesPage> {
  @override
  Widget build(BuildContext context) {
    final _providerAsignacion = new ProviderPedidoClienteOp();
    return Scaffold(
      appBar: AppBar(
        title: Text("PEDIDOS CLIENTES"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.indigo[900],
        actions: [
          IconButton(
            icon: Icon(Icons.maps_ugc_rounded),
            onPressed: () async {
              final respuesta = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CrearOperacionesPage()),
              );
              print(respuesta);
              if (respuesta == 'OK') {
                setState(() {
                  refreshList();
                });
              } else {}
            },
          ),
        ],
      ),
      body: FutureBuilder<List<ListaPedidoClienteOp>>(
        future: _providerAsignacion.getListapedidoclienteop(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ListaPedidoClienteOp>> snapshot) {
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

                                //direction: DismissDirection.,
                                key: Key(listaPersonalAux[i].nm_solicitud),
                                onDismissed: (direction) async {
                                  var nmSolicitud, cliente, idAtencionPedidos;
                                  switch (direction) {
                                    case DismissDirection.endToStart:
                                      //   idAtencionPedidos = listaPersonalAux[i].id;

                                      // TODO: Handle this case.
                                      break;
                                    case DismissDirection.startToEnd:
                                  }

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

  ListTile _banTitle(ListaPedidoClienteOp band) {
    return ListTile(
      // focusColor: Colors.black,
      //tileColor:Colors.red ,
      //hoverColor: Colors.blue,
      leading: CircleAvatar(
        child: Text(band.cliente.substring(0, 2)),
        backgroundColor: Colors.blue[900],
      ),
      title: Text(band.nm_solicitud, style: TextStyle(fontSize: 12)),
      subtitle: new Text(band.cliente, style: TextStyle(fontSize: 13)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: TextDirection.rtl,
        children: [
          Text(
            '${band.fecha} ${band.hora_recojo}',
            style: TextStyle(fontSize: 10),
          ),
          Text(
            '${band.nombre_estado}',
            style: TextStyle(fontSize: 10),
          ),
          Text(
            '${band.tipo_servicios}',
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
      onTap: () async {
        final respuesta = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditarPedidos(
                    pedidos: band,
                  )),
        );
        print(respuesta);
        if (respuesta == 'OK') {
          setState(() {
            refreshList();
          });
        } else {}
      },
    );
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      ProviderPedidoClienteOp().getListapedidoclienteop();
    });
  }
}
