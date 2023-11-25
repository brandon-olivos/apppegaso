import 'package:Pegaso/src/pages/Asignaciones/atendender_asignacion.dart';
import 'package:Pegaso/src/pages/Reparacion/Reparacion.dart';
import 'package:Pegaso/src/data/models/ListaSeguimientoAgente.dart';
import 'package:Pegaso/src/data/provider/providerLista.dart';
import 'package:flutter/material.dart';
import 'package:Pegaso/src/data/models/listaAsignacion.dart';

import 'SeguimientoAuxiliarClAux.dart';

// ignore: must_be_immutable
class SeguimientoAuxiliarPage extends StatefulWidget {
  /// String titulo;

  //SeguimientoAgenciaPage({this.titulo});
  @override
  _SeguimientoAuxiliarPageState createState() =>
      _SeguimientoAuxiliarPageState();
}

class _SeguimientoAuxiliarPageState extends State<SeguimientoAuxiliarPage> {
  final _providerLista = new ProviderLista();

  @override
  void initState() {
    super.initState();
    setState(() {
      refreshList();
      _providerLista.getListaSeguimientoAuxiliar();
    });
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 10));

    setState(() {
      _providerLista.getListaSeguimientoAuxiliar();
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      refreshList();
    });
    return Scaffold(
      body: FutureBuilder<List<ListaSeguimientoAgente>>(
        future: _providerLista.getListaSeguimientoAuxiliar(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ListaSeguimientoAgente>> snapshot) {
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
            //   setState(() {});
            return Container(
              child: RefreshIndicator(
                  child: ListView.builder(
                    itemCount: listaPersonalAux?.length,
                    itemBuilder: (context, i) => _banTitle(listaPersonalAux[i]),
                  ),
                  onRefresh: refreshList),
            );
          }
        },
      ),

      /*     floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
        elevation: 1,
      ), */
    );
  }

  ListTile _banTitle(ListaSeguimientoAgente band) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(band.cuenta.substring(0, 2)),
        backgroundColor: Colors.blue[900],
      ),
      title: Text(band.numero_guia, style: TextStyle(fontSize: 13)),
      subtitle: new Text(band.direccion, style: TextStyle(fontSize: 13)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${band.fecha_traslado}',
            style: TextStyle(fontSize: 13),
          ),
          Container(
            width: 150,
            child: Text(
              '${band.nombre_provincia}',
              style: TextStyle(fontSize: 13),
            ),
          )
        ],
      ),
      onTap: () async {
        //  _providerLista.getVia();
        await Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => SeguimientoAuxiliarClAux(
                    idGuiaRem: band.id_guia_remision,
                    tipo: band.tipo,
                  )),
        );
      },
    );
  }

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
}
