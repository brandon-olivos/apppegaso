import 'package:Pegaso/src/data/db/guia_rem_cliente.dart';
import 'package:Pegaso/src/data/db/token.dart';
import 'package:Pegaso/src/data/models/TipoCarga.dart';
import 'package:Pegaso/src/data/models/guia_rem_cliente_m.dart';
import 'package:Pegaso/src/data/provider/ProviderAsignacion.dart';
import 'package:Pegaso/src/data/provider/provider.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditarGuiaCliente extends StatefulWidget {
  static String route = '/';
  int id;
  String cantidad,
      idtipocarga,
      ft,
      oc,
      grserie,
      grnumero,
      peso,
      largo,
      ancho,
      alto,
      descripcion,
      serieg = '';

  EditarGuiaCliente(
      {this.cantidad = '',
      this.idtipocarga = '',
      this.ft = '',
      this.oc = '',
      this.grserie = '',
      this.grnumero = '',
      this.peso = '',
      this.largo = '',
      this.ancho = '',
      this.alto = '',
      this.descripcion = '',
      this.id = 0});
  @override
  _EditarGuiaClienteState createState() => _EditarGuiaClienteState();
}

class _EditarGuiaClienteState extends State<EditarGuiaCliente> {
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
  final _providerr = new Provider();

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  var idTipoCarga_;
  var selectTC = 'Seleccionar';
  final _providerAsignacion = new ProviderAsignacion();

  @override
  Widget build(BuildContext context) {
    /*   calcular() {
      detallePesoVol.text = (double.parse(detalleLargo.text) *
              double.parse(detalleAncho.text) *
              double.parse(detalleAlto.text) /
              6000)
          .toString();
    }

    setState(() {
      calcular();
    });
 */
    seleccionar() {
      return Container(
        child: FutureBuilder<List<TipoCarga>>(
          future: _providerr.getTipoCarga(),
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
                  decoration: _providerr.myBoxDecoration(),
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

    guardar() async {
      await DatabasePr.db.initDB();
      final rspt = GuiaRemClienteM(
          idTipoCarga: idTipoCarga_.toString(),
          grs: serieg.text,
          gr: numerog.text,
          ft: ft.text,
          oc: oc.text,
          cantidad: detalleCantidad.text,
          peso: detallePeso.text,
          largo: detalleLargo.text,
          ancho: detalleAncho.text,
          alto: detalleAlto.text,
          volumen: detallePesoVol.text,
          descripcion: descripcion.text);

      await DatabasePrGRC.db.editGRC(rspt, widget.id);

      setState(() {});
      Navigator.pop(context);
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
                        serienumero(),
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
                                  widget.ft = x;
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
                                  widget.oc = x;
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
                        Flexible(
                            child: new Row(
                          children: [
                            Flexible(
                              child: new TextField(
                                cursorColor: Colors.blueAccent,
                                controller: detalleCantidad,
                                obscureText: false,
                                onChanged: (x) {
                                  widget.cantidad = x;
                                },
                                keyboardType: TextInputType.number,
                                style: style,
                                decoration: InputDecoration(
                                    fillColor: Colors.blueAccent,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    hintText: 'Cantidad',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0))),
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Flexible(
                              child: new TextField(
                                cursorColor: Colors.blueAccent,
                                controller: detallePeso,
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                style: style,
                                onChanged: (x) {
                                  widget.peso = x;
                                },
                                decoration: InputDecoration(
                                    fillColor: Colors.blueAccent,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    hintText: 'Peso(kg)',
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
                          controller: detalleLargo,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          style: style,
                          onChanged: (value) {
                            setState(() {
                              widget.largo = value;
                              // calcular();
                              //calcular();
                            });
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.blueAccent,
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
                            setState(() {
                              widget.ancho = value;
                              //  calcular();
                              //* setState(() {} */
                            });
                          },
                          decoration: InputDecoration(
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
                            setState(() {
                              widget.alto = value;
                              // calcular();
                            });
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.blueAccent,
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
                          style: style,
                          decoration: InputDecoration(
                              fillColor: Colors.blueAccent,
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

  serienumero() {
    return Flexible(
        child: new Row(
      children: [
        Flexible(
          child: new TextField(
            cursorColor: Colors.blueAccent,
            controller: serieg,
            obscureText: false,
            onChanged: (x) {
              widget.grserie = x;
            },
            keyboardType: TextInputType.number,
            style: style,
            decoration: InputDecoration(
                fillColor: Colors.blueAccent,
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: 'GR Serie',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
          ),
        ),
        SizedBox(width: 5.0),
        Flexible(
          child: new TextField(
            cursorColor: Colors.blueAccent,
            controller: numerog,
            keyboardType: TextInputType.number,
            obscureText: false,
            onChanged: (x) {
              widget.grnumero = x;
            },
            style: style,
            decoration: InputDecoration(
                fillColor: Colors.blueAccent,
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: 'GR Numero',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
          ),
        ),
      ],
    ));
  }
}
