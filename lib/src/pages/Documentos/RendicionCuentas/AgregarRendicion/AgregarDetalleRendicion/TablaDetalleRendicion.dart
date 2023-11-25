import 'package:Pegaso/src/data/Print/print.dart';
import 'package:Pegaso/src/data/db/detalleRendicionCuentas.dart';
import 'package:Pegaso/src/data/models/detalleRendicionCuentasM.dart';

import 'package:Pegaso/src/data/provider/providerProcesarGuias.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TablaDetalleRendicion extends StatefulWidget {
  int idGuiaRemision;
  TablaDetalleRendicion({this.idGuiaRemision = 0});

  @override
  State<TablaDetalleRendicion> createState() => _TablaDetalleRendicionState();
}

class _TablaDetalleRendicionState extends State<TablaDetalleRendicion> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _providerGuias = new ProviderProcesarGuias();
  List<DetalleRenCuenModel> list = [];
  double datoss = 0.0;

  Future refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    var a = await DatabaseDRC.db.getDtaGRC();
    setState(() {
      traertota();
      print(a);
      list = a;
    });
  }

  Future traertota() async {
    await Future.delayed(Duration(seconds: 10));
    var a = await DatabaseDRC.db.traersumatotal();
    setState(() {
      datoss = a[0]['total'];
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      refreshList();
    });
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total: $datoss'),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(
                    label: Container(
                  width: 70,
                  child: Text('Fecha',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                )),
                DataColumn(
                    label: Text('Proveedor',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('N° de Documento',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Concepto',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Monto',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Acciones',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold))),
              ],
              rows: [
                //_providerAsignacion.getSqlGuiaRem();
                if (list = null)
                  for (var i = 0; i < list.length; i++)
                    DataRow(

                        //selected: true,
                        cells: [
                          DataCell(
                            Text(
                              '${list[i].fecha}',
                              style: TextStyle(fontSize: 10),
                            ),
                            // placeholder: true,
                            //  showEditIcon: true)
                          ),
                          DataCell(Container(
                            child: Text(
                              '${list[i].proveedor}',
                              style: TextStyle(fontSize: 10),
                            ),
                            width: 50,
                          )),
                          DataCell(Text(
                            '${list[i].ndocumento}',
                            style: TextStyle(fontSize: 10),
                          )),
                          DataCell(Text(
                            '${list[i].concepto}',
                            style: TextStyle(fontSize: 10),
                          )),
                          DataCell(Text(
                            '${list[i].monto}',
                            style: TextStyle(fontSize: 10),
                          )),
                          DataCell(Row(
                            children: [
                              accionesE(i),
                              SizedBox(width: 10.0),
                              accionesEl(list[i].id)
                            ],
                          )),
                        ]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  accionesEl(i) {
    return Material(
        elevation: 1.0,
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.red,
        child: Container(
          height: 20.0,
          width: 20.0,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () async {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Eliminar'),
                  content:
                      const Text('Desea Eliminar este detalle de rendicion'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              print(i);
                              DatabaseDRC.db.eliminarPorid(i);
                              refreshList();
                              Navigator.pop(context);
                            },
                            child: Text('Si'),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text('No'),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Text("Eliminar",
                textAlign: TextAlign.center,
                style: _providerGuias.style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ));
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
              /*  Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditarGuiaClientePage(
                        //  guiaCliente: list,
                          id: i,
                        )),
              ); */
            },
            child: Text("Editar",
                textAlign: TextAlign.center,
                style: _providerGuias.style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ));
  }
}
