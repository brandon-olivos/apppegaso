import 'package:Pegaso/src/Pages/Asignaciones/detalleguia/Detalleguiaed.dart';
import 'package:Pegaso/src/data/db/token.dart';
import 'package:Pegaso/src/data/models/guiaCliente.dart';

import 'package:Pegaso/src/data/provider/providerProcesarGuias.dart';
import 'package:Pegaso/src/pages/ProcesarGuias/Guiacliente/EdtitarGuiaClientePage.dart';
import 'package:flutter/material.dart';

class TablaGiaCliente extends StatefulWidget {
  int idGuiaRemision;
  TablaGiaCliente({this.idGuiaRemision = 0});

  @override
  State<TablaGiaCliente> createState() => _TablaGiaClienteState();
}

class _TablaGiaClienteState extends State<TablaGiaCliente> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _providerGuias = new ProviderProcesarGuias();
  List<GuiaCliente> list = [];
  Future refreshList() async {
    await Future.delayed(Duration(seconds: 10));
    var a = await _providerGuias.getListaGuiasCliente(widget.idGuiaRemision);
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
              child: Text('Guia Cliente',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            )),
            DataColumn(
                label: Text('Tipo Carga',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Descripcion',
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
                        // placeholder: true,
                        //  showEditIcon: true)
                      ),
                      DataCell(Container(
                        child: Text(
                          list[i].tipo_carga,
                          style: TextStyle(fontSize: 10),
                        ),
                        width: 50,
                      )),
                      DataCell(Text(
                        list[i].descripcion,
                        style: TextStyle(fontSize: 10),
                      )),
                      DataCell(Row(
                        children: [
                          accionesE(i),
                          SizedBox(width: 10.0),
                          accionesEl(list[i].idGuiaRemisionCliente)
                        ],
                      )),
                    ]),
          ],
        ),
      ),
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
                  title: const Text('Eliminar??'),
                  content: const Text('Desea Eliminar esta Guia?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              _providerGuias.eliminarGuiaCliente(i);
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
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditarGuiaClientePage(
                          guiaCliente: list,
                          id: i,
                        )),
              );
            },
            child: Text("Editar",
                textAlign: TextAlign.center,
                style: _providerGuias.style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ));
  }
}
