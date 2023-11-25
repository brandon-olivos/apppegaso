import 'package:Pegaso/src/data/models/listaRendicionCuenta.dart';
import 'package:Pegaso/src/data/provider/providerRendicionCuenta.dart';
import 'package:Pegaso/src/pages/Documentos/RendicionCuentas/EdiatarRendicion/DetalleRendicion/detalleRendicion.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';

import 'DetalleRendicion/detalleRcuentasTabla.dart';

class EditarRendicionPage extends StatefulWidget {
  ListaRendicionCuenta listarendicon = ListaRendicionCuenta();

  EditarRendicionPage(this.listarendicon);
  @override
  State<EditarRendicionPage> createState() => _EditarRendicionPageState();
}

class _EditarRendicionPageState extends State<EditarRendicionPage> {
  DateTime nowfec = new DateTime.now();
  final _providerRendicion = new ProviderRendicionCuenta();

  TextEditingController fechainicio = TextEditingController();
  TextEditingController nmOperacion = TextEditingController();
  TextEditingController abonoCuentaD = TextEditingController();
  TextEditingController diferenciaD = TextEditingController();
  TextEditingController importeEntregado = TextEditingController();

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    nmOperacion.text = widget.listarendicon.nrOperacion;
    abonoCuentaD.text = widget.listarendicon.abonoCuentaDe;
    diferenciaD.text = widget.listarendicon.diferenciaDepositarReembolsar;
    importeEntregado.text = widget.listarendicon.importeEntregado;

    fecha(fechatext, fecha_inicio) {
      fechainicio.text = fecha_inicio;
      return TextField(
        enabled: false,
        cursorColor: Colors.blueAccent,
        controller: fechainicio,
        obscureText: false,
        style: style,
        decoration: InputDecoration(
            labelText: fechatext,
            fillColor: Colors.blueAccent,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: fechatext,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
        onTap: () async {
          nowfec = await showDatePicker(
              context: context,
              initialDate: nowfec,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100));
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.indigo[900],
          title: Text(
            'Rend Cuentas',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.document_scanner),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DetalleRendicionPage(widget.listarendicon)),
                );
              },
            ),
          ],
          elevation: 1,
        ),
        body: Center(
            child: Container(
                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.all(21.0),
                    child: ListView(children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 5.0),
                            fecha('Fecha', widget.listarendicon.fecha),
                            SizedBox(height: 10.0),
                            new TextField(
                              enabled: false,
                              cursorColor: Colors.blueAccent,
                              controller: nmOperacion,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              style: style,
                              onChanged: (value) {
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                  labelText: 'Nro. de Operación o Ch/.',
                                  fillColor: Colors.blueAccent,
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  hintText: 'Nro. de Operación o Ch/.',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                            ),
                            SizedBox(height: 10.0),
                            TextField(
                              enabled: false,
                              cursorColor: Colors.blueAccent,
                              controller: abonoCuentaD,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              style: style,
                              onChanged: (value) {
                                widget.listarendicon.abonoCuentaDe = value;
                              },
                              decoration: InputDecoration(
                                  labelText: 'Abono a cuenta de:',
                                  fillColor: Colors.blueAccent,
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  hintText: 'Abono a cuenta de:',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                            ),
                            SizedBox(height: 10.0),
                            TextField(
                              enabled: false,
                              cursorColor: Colors.blueAccent,
                              controller: importeEntregado,
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              style: style,
                              onChanged: (value) {
                                widget.listarendicon.importeEntregado = value;
                              },
                              decoration: InputDecoration(
                                  labelText: 'Importe Entregado',
                                  fillColor: Colors.blueAccent,
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  hintText: 'Importe Entregado',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                            ),
                            SizedBox(height: 16.0),
                            TbDetalleRcuentas(
                                idRendicionCuentas:
                                    widget.listarendicon.idRendicionCuentas),
                            SizedBox(height: 10.0),
                            //Padding(
                            //padding: const EdgeInsets.all(6.0),
                            //child: Material(
                            // elevation: 4.0,
                            //borderRadius: BorderRadius.circular(30.0),
                            //color: Colors.blue[900],
                            //child: MaterialButton(
                            // minWidth: MediaQuery.of(context).size.width,
                            //padding: EdgeInsets.fromLTRB(
                            //  20.0, 15.0, 20.0, 15.0),
                            //onPressed: () {
                            // guardar();
                            // },
                            // child: Text("Guardar",
                            //   textAlign: TextAlign.center,
                            //   style: style.copyWith(
                            //     color: Colors.white,
                            //   fontWeight: FontWeight.bold)),
                            //),
                            //),
                            // )
                          ])
                    ])))));
  }

  guardar() async {
    var s = await _providerRendicion.editarRendidcion(widget.listarendicon);
    if (s == '200') {
      Navigator.pop(context);
    } else {
      print("resp $s");
    }
  }
}
