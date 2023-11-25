import 'package:Pegaso/src/data/models/listaRendicionCuenta.dart';
import 'package:Pegaso/src/data/provider/providerRendicionCuenta.dart';
import 'package:Pegaso/src/pages/Documentos/RendicionCuentas/AgregarRendicion/AgregarRendicionCuentas.dart';
import 'package:flutter/material.dart';

import 'EdiatarRendicion/EditarRendicion.dart';

// ignore: must_be_immutable
class RendicionCuentasPage extends StatefulWidget {
  String titulo;
  RendicionCuentasPage({this.titulo});
  @override
  State<RendicionCuentasPage> createState() => _RendicionCuentasPageState();
}

class _RendicionCuentasPageState extends State<RendicionCuentasPage> {
  final _providerRendicion = new ProviderRendicionCuenta();

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _providerRendicion.getListaRendidicionCuenta('');
    });
  }

  @override
  Widget build(BuildContext context) {
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
          /*  actions: [
            IconButton(
              icon: Icon(Icons.plus_one_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AgregarRendicionPage(
                            titulo: 'Agregar Rendicion Cuentas',
                          )),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                //      showSearch(
                //      context: context,
                //   delegate: CustomSearchDelegate(),
                //  );
              },
            ),
          ],*/
          elevation: 1,
        ),
        body: FutureBuilder<List<ListaRendicionCuenta>>(
          future: _providerRendicion.getListaRendidicionCuenta(''),
          builder: (BuildContext context,
              AsyncSnapshot<List<ListaRendicionCuenta>> snapshot) {
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
                          onRefresh: refreshList));
                }
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
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
  ListTile _banTitle(ListaRendicionCuenta band) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(band.fecha.substring(0, 2)),
        backgroundColor: Colors.blue[900],
      ),
      title: Text(band.fecha, style: TextStyle(fontSize: 12)),
      subtitle: new Text(band.abonoCuentaDe, style: TextStyle(fontSize: 13)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: TextDirection.rtl,
        children: [
          Text(
            'S/. ${band.importeEntregado}',
            style: TextStyle(fontSize: 10),
          ),
          //Text(
          //  '${band.totalGasto}',
          //  style: TextStyle(fontSize: 10),
          //),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditarRendicionPage(band)),
        );
        print(band.idRendicionCuentas);
      },
    );
  }
}
