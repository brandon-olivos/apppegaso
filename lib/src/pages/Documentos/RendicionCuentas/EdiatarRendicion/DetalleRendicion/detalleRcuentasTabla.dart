import 'package:Pegaso/src/data/models/listaDetalleRendicionCuenta.dart';
import 'package:Pegaso/src/data/provider/providerProcesarGuias.dart';
import 'package:Pegaso/src/data/provider/providerRendicionCuenta.dart';
import 'package:Pegaso/src/pages/Documentos/RendicionCuentas/EdiatarRendicion/DetalleRendicion/EditarDetalleRc.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TbDetalleRcuentas extends StatefulWidget {
  String idRendicionCuentas;
  TbDetalleRcuentas({this.idRendicionCuentas = ""});

  @override
  State<TbDetalleRcuentas> createState() => _TbDetalleRcuentasState();
}

class _TbDetalleRcuentasState extends State<TbDetalleRcuentas> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _providerec = new ProviderRendicionCuenta();
  final _providerGuias = new ProviderProcesarGuias();
  List<ListaDetalleRendicionCuenta> list = [];
  double datoss, saldo = 0.00;

  Future refreshList() async {
    print('LLEGO AQUI');
    await Future.delayed(Duration(seconds: 2));
    var a = await _providerec
        .getListaDetalleRendicionCuenta(widget.idRendicionCuentas);
    list = a;

    setState(() {
      if (a.length != 0) {
        saldo = double.parse(a[0].diferenciaDepositarReembolsar);
        datoss = double.parse(a[0].total);
      } else {
        datoss = 0.0;
        saldo = 0.0;
      }
    });
  }

  Future traertota() async {
    await Future.delayed(Duration(seconds: 500));
    // var a = await DatabaseDRC.db.traersumatotal();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //setState(() {});
    refreshList();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Diferencia a depositar reembolsar: S/. $saldo \n\n\n\nSubtotal consumido: S/. $datoss'),
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
                    label: Text('T.Comprobante',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold))),
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
                if (list != null)
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
                          DataCell(
                            Text(
                              '${list[i].tipoComprobante}',
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
                            '${list[i].nmDocumento}',
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
                              accionesE(
                                  int.parse(list[i].idDetalleRendicionCuentas),
                                  list[i]),
                              SizedBox(width: 10.0),
                              accionesEl(list[i].idDetalleRendicionCuentas)
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
                  content: const Text('Desea Eliminar el registro?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              print(i);
                              _providerec.deleteDetalleRendidcion(i);
                              //        DatabaseDRC.db.eliminarPorid(i);
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

  accionesE(int i, ListaDetalleRendicionCuenta detalleRendicionCuenta) {
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
              final respuesta = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EditarDetalleRcPage(detalleRendicionCuenta
                          //  guiaCliente: list,

                          ),
                ),
              );

              print("object" + respuesta.toString());
              if (respuesta.toString() == 'OK') {
                refreshList();
              }
            },
            child: Text("Editar",
                textAlign: TextAlign.center,
                style: _providerGuias.style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ));
  }
}
