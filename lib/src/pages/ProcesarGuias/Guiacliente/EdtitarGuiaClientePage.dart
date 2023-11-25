import 'dart:ffi';

import 'package:Pegaso/src/data/db/guia_rem_cliente.dart';
import 'package:Pegaso/src/data/db/token.dart';
import 'package:Pegaso/src/data/models/TipoCarga.dart';
import 'package:Pegaso/src/data/models/guiaCliente.dart';
import 'package:Pegaso/src/data/models/guia_rem_cliente_m.dart';
import 'package:Pegaso/src/data/models/listaGuiasPend.dart';
import 'package:Pegaso/src/data/provider/ProviderAsignacion.dart';
import 'package:Pegaso/src/data/provider/provider.dart';
import 'package:Pegaso/src/data/provider/providerProcesarGuias.dart';
import 'package:Pegaso/src/pages/ProcesarGuias/guiaRemisionP.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditarGuiaClientePage extends StatefulWidget {
  static String route = '/';
  List<GuiaCliente> guiaCliente;

  int id;

  EditarGuiaClientePage({this.id = 0, this.guiaCliente});

  @override
  _DetalleguiaedPageState createState() => _DetalleguiaedPageState();
}

class _DetalleguiaedPageState extends State<EditarGuiaClientePage> {
  TextEditingController detalleCantidad = TextEditingController();
  TextEditingController detallePeso = TextEditingController();
  TextEditingController detalleLargo = TextEditingController();
  TextEditingController detalleAncho = TextEditingController();
  TextEditingController detalleAlto = TextEditingController();
  TextEditingController detallePesoVol = TextEditingController();
  TextEditingController tipocarga = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController serieg = TextEditingController();
  TextEditingController numerog = TextEditingController();
  TextEditingController ft = TextEditingController();
  TextEditingController oc = TextEditingController();

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _provider = new Provider();
  var idTipoCarga_;
  var selectTC = '';
  final _providerAsignacion = new ProviderProcesarGuias();
  var alto = 0.0, largo = 0.0, ancho = 0.0;
  calcular2() {
    widget.guiaCliente[widget.id].largo = largo.toString();
    widget.guiaCliente[widget.id].ancho = ancho.toString();
    widget.guiaCliente[widget.id].alto = alto.toString();

    var largo2 = double.parse(detalleLargo.text);
    var ancho2 = double.parse(detalleAncho.text);
    var alto2 = double.parse(detalleAlto.text);

    detallePesoVol.text = (alto2 * largo2 * ancho2 / 6000).toString();
    widget.guiaCliente[widget.id].volumen = detallePesoVol.text;
    print(detallePesoVol.text);
  }

  @override
  Widget build(BuildContext context) {
    selectTC = widget.guiaCliente[widget.id].tipo_carga;
    detalleCantidad.text = widget.guiaCliente[widget.id].cantidad;
    detallePeso.text = widget.guiaCliente[widget.id].peso;
    detalleLargo.text = widget.guiaCliente[widget.id].largo;
    detalleAncho.text = widget.guiaCliente[widget.id].ancho;
    detalleAlto.text = widget.guiaCliente[widget.id].alto;
    descripcion.text = widget.guiaCliente[widget.id].descripcion;
    detallePesoVol.text = widget.guiaCliente[widget.id].volumen;
    ft.text = widget.guiaCliente[widget.id].ft;
    oc.text = widget.guiaCliente[widget.id].oc;
    serieg.text = widget.guiaCliente[widget.id].grs;
    numerog.text = widget.guiaCliente[widget.id].gr;

    seleccionar() {
      return Container(
        child: FutureBuilder<List<TipoCarga>>(
          future: _provider.getTipoCarga(),
          builder:
              (BuildContext context, AsyncSnapshot<List<TipoCarga>> snapshot) {
            TipoCarga depatalits;
            if (!snapshot.hasData) {
              if (snapshot.hasData == false) {
                return Center(
                  child: Text("¡No existen registros!"),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
            final listaPersonalAux = snapshot.data;

            if (listaPersonalAux.length == 0) {
              return Center(
                child: Text("No hay informacion"),
              );
            } else {
              return Container(
                  decoration: _provider.myBoxDecoration(),
                  child: DropdownButton<TipoCarga>(
                    //  icon: Icon(Icons.ac_unit_rounded),

                    underline: SizedBox(),
                    isExpanded: true,
                    items: snapshot.data
                        .map((user) => DropdownMenuItem<TipoCarga>(
                              child: Text(user.nombreTipoCarga),
                              value: user,
                            ))
                        .toList(),
                    onChanged: (TipoCarga newVal) {
                      setState(() {
                        depatalits = newVal;
                        idTipoCarga_ = newVal.idTipoCarga;

                        selectTC = newVal.nombreTipoCarga;
                        print(newVal.nombreTipoCarga);
                      });
                    },
                    value: depatalits,
                    hint: Text("   $selectTC"),
                  ));
            }
          },
        ),
      );
    }
/*    seleccionar() {
      return Container(
        child: FutureBuilder<List<TipoCarga>>(
          future: _provider.getTipoCarga(),
          builder:
              (BuildContext context, AsyncSnapshot<List<TipoCarga>> snapshot) {
            TipoCarga depatalits;
            if (snapshot.hasData) {
              if (snapshot.hasData == false) {
                return Center(
                  child: Text("¡No existen registros"),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
            final listaPersonalAux = snapshot.data;

            if (listaPersonalAux.length == 0) {
              return Center(
                child: Text("No hay informacion"),
              );
            } else {
              return Container(
                  decoration: _provider.myBoxDecoration(),
                  child: DropdownButton<TipoCarga>(
                    //  icon: Icon(Icons.ac_unit_rounded),

                    underline: SizedBox(),
                    isExpanded: true,
                    items: snapshot.data
                        .map((user) => DropdownMenuItem<TipoCarga>(
                              child: Text(user.nombreTipoCarga),
                              value: user,
                            ))
                        .toList(),
                    onChanged: (TipoCarga newVal) {
                      setState(() {
                        depatalits = newVal;
                        widget.guiaCliente[widget.id].idTipoCarga =
                            newVal.idTipoCarga.toString();

                        widget.guiaCliente[widget.id].tipo_carga =
                            newVal.nombreTipoCarga;
                      });
                    },
                    value: depatalits,
                    hint: Text("   $selectTC"),
                  ));
            }
          },
        ),
      );
    }*/

    guardar() async {
      await _providerAsignacion.editarGuiaCliente(
          id_guia_cliente: widget.guiaCliente[widget.id].idGuiaRemisionCliente,
          cantidad: detalleCantidad.text,
          ancho: detalleAncho.text,
          alto: detalleAlto.text,
          descripcion: descripcion.text,
          ft: ft.text,
          gr: numerog.text,
          grs: serieg.text,
          id_tipo_carga: int.parse(widget.guiaCliente[widget.id].idTipoCarga),
          largo: detalleLargo.text,
          oc: oc.text,
          peso: detallePeso.text,
          volumen: detallePesoVol.text);
      Navigator.of(context).pop();
      setState(() {});

      //   LoginUser(email.text, password.text);
    }

    return Scaffold(
      body: Center(
          child: Container(
              color: Colors.white,
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        seleccionar(),
                        SizedBox(height: 10.0),
                        Flexible(
                            child: new Row(
                          children: [
                            Flexible(
                              child: new TextField(
                                cursorColor: Colors.blueAccent,
                                controller: serieg,
                                obscureText: false,
                                onChanged: (x) {
                                  widget.guiaCliente[widget.id].grs = x;
                                },
                                keyboardType: TextInputType.text,
                                style: style,
                                decoration: InputDecoration(
                                    fillColor: Colors.blueAccent,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    hintText: 'GR Serie',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0))),
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Flexible(
                              child: new TextField(
                                cursorColor: Colors.blueAccent,
                                controller: numerog,
                                keyboardType: TextInputType.text,
                                obscureText: false,
                                onChanged: (x) {
                                  widget.guiaCliente[widget.id].gr = x;
                                },
                                style: style,
                                decoration: InputDecoration(
                                    fillColor: Colors.blueAccent,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    hintText: 'GR Numero',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0))),
                              ),
                            ),
                          ],
                        )),
                        SizedBox(height: 10.0),
                        Flexible(
                            child: new Row(
                          children: [
                            Flexible(
                              child: new TextField(
                                cursorColor: Colors.blueAccent,
                                controller: ft,
                                obscureText: false,
                                onChanged: (x) {
                                  widget.guiaCliente[widget.id].ft = x;
                                },
                                style: style,
                                decoration: InputDecoration(
                                    fillColor: Colors.blueAccent,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    hintText: 'FT',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0))),
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Flexible(
                              child: new TextField(
                                cursorColor: Colors.blueAccent,
                                controller: oc,
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                style: style,
                                onChanged: (x) {
                                  widget.guiaCliente[widget.id].oc = x;
                                },
                                decoration: InputDecoration(
                                    fillColor: Colors.blueAccent,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    hintText: 'OC',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0))),
                              ),
                            ),
                          ],
                        )),
                        SizedBox(height: 10.0),
                        new TextField(
                          cursorColor: Colors.blueAccent,
                          controller: detalleCantidad,
                          obscureText: false,
                          onChanged: (x) {
                            widget.guiaCliente[widget.id].cantidad = x;
                          },
                          keyboardType: TextInputType.number,
                          style: style,
                          decoration: InputDecoration(
                              fillColor: Colors.blueAccent,
                              labelText: 'Cantidad',
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: 'Cantidad',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                        SizedBox(height: 10.0),
                        new TextField(
                          cursorColor: Colors.blueAccent,
                          controller: detallePeso,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          style: style,
                          onChanged: (x) {
                            widget.guiaCliente[widget.id].peso = x;
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.blueAccent,
                              labelText: 'Peso(kg)',
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: 'Peso(kg)',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                        SizedBox(height: 10.0),
                        new TextField(
                          cursorColor: Colors.blueAccent,
                          controller: detalleLargo,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          style: style,
                          onChanged: (value) {
                            // widget.guiaCliente[widget.id].largo = value;
                            /// detalleLargo.text = value;
                            largo = double.parse(value);
                            calcular2();
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.blueAccent,
                              labelText: 'Largo',
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: 'Largo',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                        SizedBox(height: 10.0),
                        new TextField(
                          cursorColor: Colors.blueAccent,
                          controller: detalleAncho,
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          style: style,
                          onChanged: (value) {
                            ancho = double.parse(value);
                            calcular2();
                            //widget.guiaCliente[widget.id].ancho = value;

                            //print(value);
                            // calcular();
                          },
                          decoration: InputDecoration(
                              labelText: 'Ancho',
                              fillColor: Colors.blueAccent,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: 'Ancho',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                        SizedBox(height: 10.0),
                        new TextField(
                          cursorColor: Colors.blueAccent,
                          controller: detalleAlto,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          style: style,
                          onChanged: (value) {
                            //widget.guiaCliente[widget.id].alto = value;

                            alto = double.parse(value);
                            calcular2();
                            //  setState(() {});
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.blueAccent,
                              labelText: 'Alto',
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: 'Alto',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                        SizedBox(height: 10.0),
                        new TextField(
                          cursorColor: Colors.blueAccent,
                          controller: detallePesoVol,
                          obscureText: false,
                          enabled: false,
                          onChanged: (v) {
                            setState(() {
                              //  calcular();
                            });
                          },
                          style: style,
                          decoration: InputDecoration(
                              fillColor: Colors.blueAccent,
                              labelText: 'Peso Volumen',
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: 'Peso Volumen',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                        SizedBox(height: 10.0),
                        new TextField(
                          cursorColor: Colors.blueAccent,
                          controller: descripcion,
                          obscureText: false,
                          onChanged: (x) {
                            widget.guiaCliente[widget.id].descripcion = x;
                          },
                          style: style,
                          decoration: InputDecoration(
                              fillColor: Colors.blueAccent,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: 'Descripcion',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                        SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Material(
                            elevation: 4.0,
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.blue[900],
                            child: MaterialButton(
                              minWidth: MediaQuery.of(context).size.width,
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              onPressed: () {
                                setState(() {
                                  guardar();
                                });
                              },
                              child: Text("Guardar",
                                  textAlign: TextAlign.center,
                                  style: style.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ])))),
    );
  }
}
