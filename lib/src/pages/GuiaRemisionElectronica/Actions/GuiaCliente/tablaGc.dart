import 'package:Pegaso/src/data/models/guiaCliente.dart';
import 'package:Pegaso/src/data/provider/providerProcesarGuias.dart';
import 'package:Pegaso/src/pages/GuiaRemisionElectronica/Actions/GuiaCliente/editarGcGre.dart';
import 'package:flutter/material.dart';

class TablaGc extends StatefulWidget {
  int idGuiaRemision;
  TablaGc({this.idGuiaRemision = 0});

  @override
  State<TablaGc> createState() => _TablaGcState();
}

class _TablaGcState extends State<TablaGc> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _providerGuias = new ProviderProcesarGuias();
  List<GuiaCliente> list = [];
  Future refreshList() async {
    await Future.delayed(Duration(seconds: 3));
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
                label: Text('Ver Detalle',
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
                        children: [accionesE(i), SizedBox(width: 10.0)],
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
                    builder: (context) => EditarGcPage(
                          guiaCliente: list,
                          id: i,
                        )),
              );
            },
            child: Text("Ver",
                textAlign: TextAlign.center,
                style: _providerGuias.style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ));
  }
}
