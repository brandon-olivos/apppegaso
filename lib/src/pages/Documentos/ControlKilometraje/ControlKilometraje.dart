import 'package:Pegaso/src/data/models/MControlKilometraje.dart';
import 'package:Pegaso/src/data/provider/ProviderControlKilometraje.dart';
import 'package:Pegaso/src/pages/Documentos/ControlKilometraje/AgregarCK/AgregarCk.dart';
import 'package:flutter/material.dart';

class ControlKilometrajePage extends StatefulWidget {
  @override
  State<ControlKilometrajePage> createState() => _ControlKilometrajePageState();
}

class _ControlKilometrajePageState extends State<ControlKilometrajePage> {
  final _providerRendicion = new ProviderControlKilometraje();

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _providerRendicion.getListaControlKilometraje('');
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
            'Control Kilometraje',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.plus_one_outlined),
              onPressed: () async {
                final respuesta = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AgregarControlKilometrajePage()),
                );
                print('mi ree' + respuesta.toString());
                if (respuesta.toString() == 'OK') {
                  refreshList();
                }
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
          ],
          elevation: 1,
        ),
        body: FutureBuilder<List<MControlKilometraje>>(
          future: _providerRendicion.getListaControlKilometraje(''),
          builder: (BuildContext context,
              AsyncSnapshot<List<MControlKilometraje>> snapshot) {
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
                            itemCount: listaPersonalAux?.length,
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
  ListTile _banTitle(MControlKilometraje band) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(band.horaLlegada.substring(0, 2)),
        backgroundColor: Colors.blue[900],
      ),
      title: Text(band.nombreVehiculo, style: TextStyle(fontSize: 12)),
      subtitle: new Text(
          'Hora Salida: ${band.horaSalida} - Hora Llegada: ${band.horaLlegada}',
          style: TextStyle(fontSize: 13)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: TextDirection.rtl,
        children: [
          /*    Text(
            '${band.nrOperacion}',
            style: TextStyle(fontSize: 10),
          ),
          Text(
            '${band.totalGasto}',
            style: TextStyle(fontSize: 10),
          ), */
        ],
      ),
      onTap: () {
        /*Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditarRendicionPage(band)),
        );
        print(band.idRendicionCuentas); */
      },
    );
  }
}
