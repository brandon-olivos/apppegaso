import 'package:Pegaso/src/pages/Asignaciones/atendender_asignacion.dart';
import 'package:Pegaso/src/pages/Reparacion/Reparacion.dart';
import 'package:Pegaso/src/pages/Seguimiento/seguimiento_agencia/SeguimientoAgCl.dart';
import 'package:Pegaso/src/data/models/ListaSeguimientoAgente.dart';
import 'package:Pegaso/src/data/provider/providerLista.dart';
import 'package:flutter/material.dart';
import 'package:Pegaso/src/data/models/listaAsignacion.dart';

// ignore: must_be_immutable
class SeguimientoAgenciaAtePage extends StatefulWidget {
  /// String titulo;

  //SeguimientoAgenciaPage({this.titulo});
  @override
  _SeguimientoAgenciaPageState createState() => _SeguimientoAgenciaPageState();
}

class _SeguimientoAgenciaPageState extends State<SeguimientoAgenciaAtePage> {
  final _providerLista = new ProviderLista();

  @override
  void initState() {
    super.initState();
    setState(() {
      refreshList();
      _providerLista.getListaSeguimientoAgenteAte();
    });
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _providerLista.getListaSeguimientoAgenteAte();
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      refreshList();
    });
    return Scaffold(
      /*  appBar: AppBar(
        title: Text(
          'Guia Remision - Seg',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[900],
        elevation: 1,
      ), */
      body: FutureBuilder<List<ListaSeguimientoAgente>>(
        future: _providerLista.getListaSeguimientoAgenteAte(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ListaSeguimientoAgente>> snapshot) {
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
        await Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => SeguimientoAgClPage(
                    idGuiaRem: band.id_guia_remision,
                    tipo: band.tipo,

                    //id: band.id_guia_remision,
                    //  fecha: band.fecha_traslado,
                  )),
        );
      },
    );
  }

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
}
