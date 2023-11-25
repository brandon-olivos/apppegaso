import 'package:flutter/material.dart';
import 'package:Pegaso/src/data/models/listaAsignacion.dart';

class SolicitudesPage extends StatefulWidget {
  @override
  _SolicitudesPageState createState() => _SolicitudesPageState();
}

class _SolicitudesPageState extends State<SolicitudesPage> {
  List<ListaAsignacion> bands = [
    ListaAsignacion(id: '1', contacto: 'MANT. PC', telefono: ' 1'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) => _banTitle(bands[i]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
        elevation: 1,
      ),
    );
  }

  ListTile _banTitle(ListaAsignacion band) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(band.contacto.substring(0, 2)),
        backgroundColor: Colors.blue[100],
      ),
      title: Text(band.contacto),
      trailing: Text(
        '${band.telefono}',
        style: TextStyle(fontSize: 20),
      ),
      onTap: () {
        //     ventanaEmergente();
      },
    );
  }
}
