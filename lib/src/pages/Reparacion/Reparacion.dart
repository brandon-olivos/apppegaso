import 'package:flutter/material.dart';
import 'package:Pegaso/src/data/models/listaAsignacion.dart';

class ReparacionPage extends StatefulWidget {
  @override
  _ReparacionPageState createState() => _ReparacionPageState();
}

class _ReparacionPageState extends State<ReparacionPage> {
  List<ListaAsignacion> bands = [
    ListaAsignacion(id: '1', contacto: 'REP. PC', telefono: ' 1'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'REPARACION',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff7A56D0),
        elevation: 1,
      ),
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
        child: Text(
          band.contacto.substring(0, 2),
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff7A56D0),
      ),
      title: Text(band.contacto),
      trailing: Text(
        '${band.telefono}',
        style: TextStyle(fontSize: 20),
      ),
      onTap: () {
        ventanaEmergente();
      },
    );
  }

  final _formKey = GlobalKey<FormState>();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  ventanaEmergente() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Color(0xff7A56D0),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new TextField(
                        decoration: InputDecoration(
                            fillColor: Color(0xff7A56D0),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Detalle del problema",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0))),
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Material(
                          elevation: 4.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Color(0xff7A56D0),
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Enviar",
                                textAlign: TextAlign.center,
                                style: style.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
