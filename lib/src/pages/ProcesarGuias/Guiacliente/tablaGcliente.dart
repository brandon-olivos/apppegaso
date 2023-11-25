import 'package:Pegaso/src/data/models/guiaCliente.dart';
import 'package:Pegaso/src/data/provider/providerProcesarGuias.dart';
import 'package:Pegaso/src/pages/ProcesarGuias/Guiacliente/EdtitarGuiaClientePage.dart';
import 'package:flutter/material.dart';

class TablaGiaClientePro extends StatefulWidget {
  const TablaGiaClientePro({Key key, this.title, this.idGuiaRemision})
      : super(key: key);

  final String title;
  final int idGuiaRemision;

  @override
  State<TablaGiaClientePro> createState() => _TablaGiaClienteProState();
}

class _TablaGiaClienteProState extends State<TablaGiaClientePro> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _providerGuias = new ProviderProcesarGuias();

  List<GuiaCliente> list = [];
  Future refreshList() async {
    await Future.delayed(Duration(seconds: 3));
    var a = await _providerGuias.getListaGuiasCliente(widget.idGuiaRemision);
    list = a;
    setState(() {});
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
                      DataCell(Container(
                        child: Text(
                          list[i].descripcion,
                          style: TextStyle(fontSize: 10),
                        ),
                        width: 150,
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
                  title: const Text('Eliminar'),
                  content: const Text('Desea Eliminar esta Guia'),
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
              /*      var a =

              if (a = null) {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Eliminado'),
                    //   content: const Text('Desea Eliminar La Guia Cliente'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }*/

              //   LoginUser(email.text, password.text);
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
