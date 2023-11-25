import 'package:Pegaso/src/data/models/TipoCarga.dart';
import 'package:Pegaso/src/data/models/guiaCliente.dart';
import 'package:Pegaso/src/data/provider/provider.dart';
import 'package:Pegaso/src/data/provider/providerProcesarGuias.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditarGcPage extends StatefulWidget {
  static String route = '/';
  List<GuiaCliente> guiaCliente;

  int id;

  EditarGcPage({this.id = 0, this.guiaCliente});

  @override
  _DetalleguiaedPageState createState() => _DetalleguiaedPageState();
}

class _DetalleguiaedPageState extends State<EditarGcPage> {
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
  var alto = 0.0, largo = 0.0, ancho = 0.0;

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
                                maxLines: 1,
                                enabled: false,
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
                                maxLines: 1,
                                enabled: false,
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
                                maxLines: 1,
                                enabled: false,
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
                                maxLines: 1,
                                enabled: false,
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
                          maxLines: 1,
                          enabled: false,
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
                          maxLines: 1,
                          enabled: false,
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
                          maxLines: 1,
                          enabled: false,
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
                          maxLines: 1,
                          enabled: false,
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
                          maxLines: 1,
                          enabled: false,
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
                          maxLines: 1,
                          enabled: false,
                          style: style,
                          decoration: InputDecoration(
                              fillColor: Colors.blueAccent,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: 'Descripcion',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                      ],
                    ),
                  ])))),
    );
  }
}
