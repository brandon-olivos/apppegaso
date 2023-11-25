import 'dart:typed_data';
import 'dart:io';

import 'package:Pegaso/src/data/models/listaDetallePedido.dart';
import 'package:Pegaso/src/data/provider/ProviderAsignacion.dart';
import 'package:flutter/material.dart';
import 'package:Pegaso/src/data/Print/print.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

// ignore: use_key_in_widget_constructors
class ImprimirHome extends StatefulWidget {
  String solicitud = '';
  String cliente = '';
  ImprimirHome({this.solicitud = '', this.cliente = ''});

  @override
  State<ImprimirHome> createState() => _ImprimirHomeState();
}

class _ImprimirHomeState extends State<ImprimirHome> {
  final provider = new ProviderAsignacion();
  List list = [];

  /// Example Data
  int _total = 0;
  List<ListaDetallePedido> lsist;
  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 1));
    var a = await provider.getBuscarPorpedido(widget.solicitud);
    setState(() {
      _total = a.length;
      //   lsist = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    refreshList();

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.cliente}'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.indigo[900],
        elevation: 1,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder<List<ListaDetallePedido>>(
              future: provider.getBuscarPorpedido(widget.solicitud),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ListaDetallePedido>> snapshot) {
                if (!snapshot.hasData) {
                  if (snapshot.hasData == false) {
                    return Center(
                      child: Text("¡No existen registros!"),
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
                  // totalgas = 'Guias: ${snapshot.data!.length}';
                  lsist = listaPersonalAux;
                  return Container(
                    child: ListView.builder(
                      itemCount: listaPersonalAux?.length,
                      itemBuilder: (c, i) {
                        return ListTile(
                          title: Text('${listaPersonalAux[i].numeroGuia}'),
                          subtitle: Text(
                              '${listaPersonalAux[i].nombreVia} Bulto: ${listaPersonalAux[i].cantidad}'),
                          trailing: Text('${listaPersonalAux[i].destino}'),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'Total :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$_total',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(width: 20),
                Expanded(
                  child: FlatButton(
                    color: Colors.indigo[900],
                    textColor: Colors.white,
                    child: Text('Imprimir'),
                    onPressed: () {
                      setState(() {
                        refreshList();
                      });
                      if (_total == 0) {
                        print("no hay guias para imprimir");
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Alto!!!'),
                            content: const Text('No hay guias para imprimir'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        print(widget.cliente);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Print(
                                    lsist, widget.cliente, widget.solicitud)));
                      }
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
