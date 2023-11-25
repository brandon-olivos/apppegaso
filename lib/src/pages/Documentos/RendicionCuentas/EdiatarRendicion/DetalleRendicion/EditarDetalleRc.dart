import 'package:Pegaso/src/data/models/listaDetalleRendicionCuenta.dart';
import 'package:Pegaso/src/data/provider/providerRendicionCuenta.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:Pegaso/src/data/models/Tipocomprobante.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:Pegaso/src/data/provider/providerProcesarGuias.dart';

class EditarDetalleRcPage extends StatefulWidget {
  ListaDetalleRendicionCuenta detalleRendicionCuenta =
      new ListaDetalleRendicionCuenta();

  EditarDetalleRcPage(this.detalleRendicionCuenta);

  @override
  State<EditarDetalleRcPage> createState() => _EditarDetalleRcPageState();
}

class _EditarDetalleRcPageState extends State<EditarDetalleRcPage> {
  TextEditingController proveedor = TextEditingController();
  TextEditingController ndocumento = TextEditingController();
  TextEditingController concepto = TextEditingController();
  TextEditingController monto = TextEditingController();
  TextEditingController tcomprobante = TextEditingController();

  var formatter = new DateFormat('yyyy-MM-dd');
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  var idTipoCarga_;
  var selectTC = 'Seleccionar';
  DateTime nowfec = new DateTime.now();
  TextEditingController fechainicio = TextEditingController();
  ListaDetalleRendicionCuenta detalleRendicionCuenta =
      new ListaDetalleRendicionCuenta();
  ProviderRendicionCuenta providerRc = ProviderRendicionCuenta();

  @override
  Widget build(BuildContext context) {
    String formattedDate = formatter.format(nowfec);

    detalleRendicionCuenta.fecha = formattedDate;
    monto.text = widget.detalleRendicionCuenta.monto;
    proveedor.text = widget.detalleRendicionCuenta.proveedor;
    ndocumento.text = widget.detalleRendicionCuenta.nmDocumento;
    concepto.text = widget.detalleRendicionCuenta.concepto;
    tcomprobante.text =
        widget.detalleRendicionCuenta.tipoComprobante.toString();

    //proveedor.text =  detalleRendicionCuenta.proveedor
    //  proveedor.text=widget.listarendicon.

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.indigo[900],
        title: Text(
          'Editar Detalle resndicion',
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
                        fecha('Fecha', formattedDate),
                        SizedBox(height: 10.0),
                        tipocomprobante('T.Comprobante', tcomprobante),
                        SizedBox(height: 10.0),
                        new TextField(
                          cursorColor: Colors.blueAccent,
                          controller: proveedor,
                          obscureText: false,
                          style: style,
                          onChanged: (value) {
                            widget.detalleRendicionCuenta.proveedor = value;
                          },
                          decoration: InputDecoration(
                              labelText: 'Proveedor',
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
                          onChanged: (value) {
                            widget.detalleRendicionCuenta.nmDocumento = value;
                          },
                          decoration: InputDecoration(
                              labelText: 'N° de Documento',
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
                          onChanged: (value) =>
                              widget.detalleRendicionCuenta.concepto = value,
                          decoration: InputDecoration(
                              labelText: 'Concepto',
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
                          onChanged: (value) =>
                              widget.detalleRendicionCuenta.monto = value,
                          decoration: InputDecoration(
                              labelText: 'S/.',
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

  fecha(fechatext, fecha_inicio) {
    fechainicio.text = fecha_inicio;
    return TextField(
      cursorColor: Colors.blueAccent,
      controller: fechainicio,
      obscureText: false,
      style: style,
      onChanged: (value) => detalleRendicionCuenta.fecha = value,
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

        setState(() {
          fechainicio.text.replaceAll('', formatter.format(nowfec));
        });
      },
    );
  }

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
            widget.detalleRendicionCuenta.tipoComprobante =
                suggestion.descripcion;
            widget.detalleRendicionCuenta.idTipoComprobante =
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

  guardar() async {
    var s = await providerRc.editarDetRendidcion(widget.detalleRendicionCuenta);
    print(s);
    if (s == '200') {
      Navigator.pop(context, 'OK');
    } else {
      print("resp $s");
    }
  }
}
