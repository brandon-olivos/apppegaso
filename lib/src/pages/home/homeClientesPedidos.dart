import 'package:Pegaso/src/pages/PedidosClientes/CrearPedidoCliente.dart';
import 'package:Pegaso/src/pages/PedidosClientes/PedidosClientes.dart';
import 'package:Pegaso/src/pages/SeguimientoNuevo/SeguimientoAuxiliarNuevo.dart';
import 'package:Pegaso/src/pages/Login/config_usuario.dart';
import 'package:Pegaso/src/pages/home/appbar/AppBar.dart';
import 'package:flutter/material.dart';

class HomeClientesPedidos extends StatefulWidget {
  String titulo;

  HomeClientesPedidos({this.titulo});
  @override
  _HomeClientesPedidosState createState() => _HomeClientesPedidosState();
}

class _HomeClientesPedidosState extends State<HomeClientesPedidos> {
  int currenIndex = 0;
  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

    botones(nombre, icono) {
      return InkWell(
        onTap: () {
          switch (nombre) {
            case 'Crear Pedido':
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CrearPedidoCliente(
                          titulo: nombre,
                        )),
              );
              break;

            case 'Lista de Pedidos':
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PedidosClientes(
                          titulo: "Lista de Pedidos",
                        )),
              );
              break;
          }
        },
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    icono,
                    color: Colors.orange,
                    size: 60,
                  ),
                ],
              ),
              ListTile(
                title: Center(
                    child: Text("" + nombre,
                        textAlign: TextAlign.center,
                        style: style.copyWith(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold))),
              ),
            ],
          ),
        ),
      );
    }

    List listPages = [
      Container(
          child: Column(
        children: <Widget>[
          Expanded(
              flex: 6,
              child: Center(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Center(
                      child: GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        //shrinkWrap: true,
                        children: [
                          botones("Crear Pedido", Icons.create_outlined),
                          botones("Lista de Pedidos", Icons.list),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ],
      )),
    ];

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
        actions: [],
        elevation: 1,
      ),
      //body: listPages[currenIndex]);
      body: Stack(
        children: <Widget>[listPages[currenIndex]],
      ),
    );
  }
}
