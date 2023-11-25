import 'package:Pegaso/src/data/models/grclienteseguimiento.dart';
import 'package:Pegaso/src/pages/SeguimientoCliente/VerGuiaCliente.dart';
import 'package:Pegaso/src/data/provider/providerLista.dart';
import 'package:flutter/material.dart';

class TablaGCSeguimientoCliente extends StatefulWidget {
  int idGuiaRemision;

  TablaGCSeguimientoCliente({this.idGuiaRemision = 0});

  @override
  State<TablaGCSeguimientoCliente> createState() =>
      _TablaGCSeguimientoClienteState();
}

class _TablaGCSeguimientoClienteState extends State<TablaGCSeguimientoCliente> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _providerLista = new ProviderLista();
  List<GRClienteSeguimiento> list = [];
  Future refreshList() async {
    //await Future.delayed(Duration(seconds: 2));
    var a = await _providerLista.getlistaguiacliente(widget.idGuiaRemision);
    setState(() {
      list = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      refreshList();
    });
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
                label: Container(
              width: 70,
              child: Text('N° GRC',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            )),
            DataColumn(
                label: Text('Sta.Merc.',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Fec.Ent',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Sta.Cargo',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Fec.Cargo',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Recibido por',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Acciones',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
          ],
          rows: [
            //_providerAsignacion.getSqlGuiaRem();
            if (list != null)
              for (var i = 0; i < list.length; i++)
                DataRow(

                    //selected: true,
                    cells: [
                      DataCell(
                        Text(
                          list[i].grs + '-' + list[i].gr,
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      DataCell(Container(
                        child: Text(
                          list[i].estado_mercaderia,
                          style: TextStyle(fontSize: 10),
                        ),
                        width: 60,
                      )),
                      DataCell(Container(
                        child: Text(
                          list[i].fecha_hora_entrega,
                          style: TextStyle(fontSize: 10),
                        ),
                        width: 55,
                      )),
                      DataCell(Container(
                        child: Text(
                          list[i].estado_cargo,
                          style: TextStyle(fontSize: 10),
                        ),
                        width: 60,
                      )),
                      DataCell(Container(
                        child: Text(
                          list[i].fecha_cargo,
                          style: TextStyle(fontSize: 10),
                        ),
                        width: 55,
                      )),
                      DataCell(Container(
                        child: Text(
                          list[i].recibido_por,
                          style: TextStyle(fontSize: 10),
                        ),
                        width: 60,
                      )),
                      DataCell(Row(
                        children: [
                          accionesE(i),
                          SizedBox(width: 10.0),
                        ],
                      )),
                    ]),
          ],
        ),
      ),
    );
  }

  accionesE(int i) {
    return Material(
        elevation: 1.0,
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.green,
        child: Container(
          height: 20.0,
          width: 20.0,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () async {
              print(i);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VerImagenGuiaClientePage(
                          guiaCliente: list,
                          id: i,
                        )),
              );
            },
            child: Text("Editar",
                textAlign: TextAlign.center,
                style: _providerLista.style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ));
  }
}
