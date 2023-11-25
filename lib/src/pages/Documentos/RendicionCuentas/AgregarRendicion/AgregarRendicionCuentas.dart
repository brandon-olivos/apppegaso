import 'package:Pegaso/src/data/provider/providerRendicionCuenta.dart';
import 'package:Pegaso/src/pages/Documentos/RendicionCuentas/AgregarRendicion/AgregarDetalleRendicion/CrearDetalleRendicion.dart';
import 'package:Pegaso/src/pages/Documentos/RendicionCuentas/AgregarRendicion/AgregarDetalleRendicion/TablaDetalleRendicion.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';

class AgregarRendicionPage extends StatefulWidget {
  String titulo;

  AgregarRendicionPage({this.titulo});

  @override
  State<AgregarRendicionPage> createState() => _AgregarRendicionPageState();
}

class _AgregarRendicionPageState extends State<AgregarRendicionPage> {
  DateTime nowfec = new DateTime.now();
  final _providerRendicion = new ProviderRendicionCuenta();

  TextEditingController fechainicio = TextEditingController();
  TextEditingController nmOperacion = TextEditingController();
  TextEditingController abonoCuentaD = TextEditingController();
  TextEditingController diferenciaD = TextEditingController();
  TextEditingController importeEntregado = TextEditingController();

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  var formatter = new DateFormat('yyyy-MM-dd');
  @override
  Widget build(BuildContext context) {
    String formattedDate = formatter.format(nowfec);

    fecha(fechatext, fecha_inicio) {
      fechainicio.text = fecha_inicio;
      return TextField(
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
          print(formattedDate); // 2016-01-25
          nowfec = await showDatePicker(
              context: context,
              initialDate: nowfec,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100));

          setState(() {
            fechainicio.text.replaceAll('', formatter.format(nowfec));
            //  fecha_inicio.text = nowfec.toIso8601String();
          });
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
            '${widget.titulo}',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.document_scanner),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CrearDetalleRendicion(
                            titulo: 'Detalle Rendicion Cuentas',
                          )),
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
                            fecha('Fecha', formattedDate),
                            SizedBox(height: 10.0),
                            new TextField(
                              cursorColor: Colors.blueAccent,
                              controller: nmOperacion,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              style: style,
                              onChanged: (value) {
                                setState(() {
                                  //     widget.largo = value;
                                  //  calcular();
                                });
                              },
                              decoration: InputDecoration(
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
                              cursorColor: Colors.blueAccent,
                              controller: abonoCuentaD,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              style: style,
                              onChanged: (value) {
                                setState(() {
                                  //     widget.largo = value;
                                  //  calcular();
                                });
                              },
                              decoration: InputDecoration(
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
                              cursorColor: Colors.blueAccent,
                              controller: diferenciaD,
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              style: style,
                              onChanged: (value) {
                                setState(() {
                                  //     widget.largo = value;
                                  //  calcular();
                                });
                              },
                              decoration: InputDecoration(
                                  fillColor: Colors.blueAccent,
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  hintText:
                                      'Diferencia por depositar o saldo a reembolsar',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                            ),
                            SizedBox(height: 10.0),
                            TextField(
                              cursorColor: Colors.blueAccent,
                              controller: importeEntregado,
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              style: style,
                              onChanged: (value) {
                                setState(() {
                                  //     widget.largo = value;
                                  //  calcular();
                                });
                              },
                              decoration: InputDecoration(
                                  fillColor: Colors.blueAccent,
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  hintText: 'Importe Entregado',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                            ),
                            SizedBox(height: 10.0),
                            TablaDetalleRendicion(),
                            SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Material(
                                elevation: 4.0,
                                borderRadius: BorderRadius.circular(30.0),
                                color: Colors.blue[900],
                                child: MaterialButton(
                                  minWidth: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  onPressed: () {
                                    guardar();
                                  },
                                  child: Text("Guardar",
                                      textAlign: TextAlign.center,
                                      style: style.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            )
                          ])
                    ])))));
  }

  guardar() async {
    var s = await _providerRendicion.registrarRendidcion(
        fecha: fechainicio.text,
        abonoCuenta: abonoCuentaD.text,
        diferenciaDepositar: diferenciaD.text,
        importeEntregado: importeEntregado.text,
        //rinde: 'persona',
        nmOperacion: nmOperacion.text);
    if (s == '200') {
      Navigator.pop(context);
    } else {
      print("resp $s");
    }
  }
}
