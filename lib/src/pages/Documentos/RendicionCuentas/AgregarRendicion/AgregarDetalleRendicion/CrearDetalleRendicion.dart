import 'package:Pegaso/src/data/db/detalleRendicionCuentas.dart';
import 'package:Pegaso/src/data/db/guia_rem_cliente.dart';
import 'package:Pegaso/src/data/db/token.dart';
import 'package:Pegaso/src/data/models/TipoCarga.dart';
import 'package:Pegaso/src/data/models/Tipocomprobante.dart';
import 'package:Pegaso/src/data/models/detalleRendicionCuentasM.dart';
import 'package:Pegaso/src/data/models/guia_rem_cliente_m.dart';
import 'package:Pegaso/src/data/provider/ProviderAsignacion.dart';
import 'package:Pegaso/src/data/provider/provider.dart';
import 'package:Pegaso/src/data/provider/providerProcesarGuias.dart';
import 'package:Pegaso/src/pages/Asignaciones/detalle_grc.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class CrearDetalleRendicion extends StatefulWidget {
  static String route = '/';

  String titulo;

  CrearDetalleRendicion({this.titulo = ""});
  @override
  _CrearDetalleRendicionState createState() => _CrearDetalleRendicionState();
}

DetalleRenCuenModel _detalleRenCuenModel = DetalleRenCuenModel();

class _CrearDetalleRendicionState extends State<CrearDetalleRendicion> {
  TextEditingController proveedor = TextEditingController();
  TextEditingController ndocumento = TextEditingController();
  TextEditingController concepto = TextEditingController();
  TextEditingController monto = TextEditingController();
  TextEditingController tcomprobante = TextEditingController();

  final _providerGuias = new ProviderProcesarGuias();
  final _providerr = new Provider();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  var idTipoCarga_;
  var selectTC = 'Seleccionar';
  final _providerAsignacion = new ProviderAsignacion();
  DateTime nowfec = new DateTime.now();
  TextEditingController fechainicio = TextEditingController();
  var formatter = new DateFormat('yyyy-MM-dd');
  @override
  Widget build(BuildContext context) {
    String formattedDate = formatter.format(nowfec);

    /*

    setState(() {
      calcular();
    });
 */
    tipocomprobante(textAuxiliar, controlador) {
      return Container(
        padding: EdgeInsets.all(0),
        child: TypeAheadField<TipoComprobante>(
          hideSuggestionsOnKeyboardHide: true,
          debounceDuration: Duration(milliseconds: 500),
          textFieldConfiguration: TextFieldConfiguration(
            controller: controlador,
            decoration: InputDecoration(
                labelText: textAuxiliar,
                fillColor: Color(0xFF3949AB),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: textAuxiliar,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hoverColor: Color(0xFF3949AB),
                focusColor: Color(0xFF3949AB)),
          ),
          suggestionsCallback:
              ProviderProcesarGuias.getDSuggestionstipocomprobante,
          itemBuilder: (context, TipoComprobante suggestion) {
            final user = suggestion;

            return ListTile(
              title: Text(user.descripcion),
            );
          },
          noItemsFoundBuilder: (context) => Container(
            height: 100,
            child: Center(
              child: Text(
                'No Perfil',
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
          onSuggestionSelected: (TipoComprobante suggestion) {
            setState(() {
              controlador.text = suggestion.descripcion;
              _detalleRenCuenModel.idTipoComprobante =
                  suggestion.idTipoComprobante;
              textAuxiliar.replaceAll('', suggestion.descripcion);
            });
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                  SnackBar(content: Text('${suggestion.idTipoComprobante}')));
          },
        ),
      );
    }

    fecha(fechatext, fecha_inicio) {
      String fecha_inicio = formatter.format(nowfec);

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
          FocusScope.of(context).requestFocus(new FocusNode());

          nowfec = await showDatePicker(
              context: context,
              initialDate: nowfec,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100));

          setState(() {
            fechainicio.text.replaceAll('', formatter.format(nowfec));
            fecha_inicio = formatter.format(nowfec);
          });
        },
      );
    }

    guardar() async {
      await DatabaseDRC.db.initDB();
      final rspt = DetalleRenCuenModel(
          fecha: fechainicio.text,
          proveedor: proveedor.text,
          ndocumento: ndocumento.text,
          concepto: concepto.text,
          monto: double.parse(monto.text));

      await DatabaseDRC.db.insertDetalleRC(rspt);

      setState(() {});
      Navigator.pop(context);
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
        actions: [],
        elevation: 1,
      ),
      body: Center(
          child: Container(
              color: Colors.white,
              child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ListView(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        fecha('Fechsssa', formattedDate),
                        SizedBox(height: 10.0),
                        tipocomprobante('T.Comprobante', tcomprobante),
                        SizedBox(height: 10.0),
                        new TextField(
                          cursorColor: Colors.blueAccent,
                          controller: proveedor,
                          obscureText: false,
                          style: style,
                          decoration: InputDecoration(
                              fillColor: Colors.blueAccent,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: 'Proveedor',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                        SizedBox(height: 10.0),
                        new TextField(
                          cursorColor: Colors.blueAccent,
                          controller: ndocumento,
                          obscureText: false,
                          style: style,
                          decoration: InputDecoration(
                              fillColor: Colors.blueAccent,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: 'N° de Documento',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                        SizedBox(height: 10.0),
                        new TextField(
                          cursorColor: Colors.blueAccent,
                          controller: concepto,
                          obscureText: false,
                          style: style,
                          decoration: InputDecoration(
                              fillColor: Colors.blueAccent,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: 'Concepto',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                        SizedBox(height: 10.0),
                        new TextField(
                          cursorColor: Colors.blueAccent,
                          controller: monto,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          style: style,
                          decoration: InputDecoration(
                              fillColor: Colors.blueAccent,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: 'S/.',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                        SizedBox(height: 10.0),
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
                      ],
                    ),
                  ])))),
    );
  }
}
