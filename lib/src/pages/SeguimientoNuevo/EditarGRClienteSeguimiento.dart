import 'package:Pegaso/src/data/provider/providerLista.dart';
import 'package:Pegaso/src/data/provider/provider.dart';
import 'package:Pegaso/src/data/models/grclienteseguimiento.dart';
import 'package:Pegaso/src/data/models/estados.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

// ignore: must_be_immutable
class EditaGRCSeguimientoPage extends StatefulWidget {
  List<GRClienteSeguimiento> guiaCliente;

  int id;
  EditaGRCSeguimientoPage({this.id = 0, this.guiaCliente});

  @override
  _DetalleguiaedPageState createState() => _DetalleguiaedPageState();
}

class _DetalleguiaedPageState extends State<EditaGRCSeguimientoPage> {
  TextEditingController guia_cliente = TextEditingController();
  TextEditingController tipo_carga = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController estado_mercaderia = TextEditingController();
  TextEditingController fecha_hora_entrega = TextEditingController();
  TextEditingController estado_cargo = TextEditingController();
  TextEditingController fecha_cargo = TextEditingController();
  TextEditingController recibido_por = TextEditingController();
  TextEditingController entregado_por = TextEditingController();
  TextEditingController observacion = TextEditingController();
  TextEditingController ft = TextEditingController();
  TextEditingController oc = TextEditingController();

  DateTime currentDate = DateTime.now();

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 17.0);
  final _provider = new Provider();

  final _providerlista = new ProviderLista();

  @override
  Widget build(BuildContext context) {
    descripcion.text = widget.guiaCliente[widget.id].descripcion;
    ft.text = widget.guiaCliente[widget.id].ft;
    oc.text = widget.guiaCliente[widget.id].oc;

    guia_cliente.text = widget.guiaCliente[widget.id].guia_cliente;
    tipo_carga.text = widget.guiaCliente[widget.id].tipo_carga;
    estado_mercaderia.text = widget.guiaCliente[widget.id].estado_mercaderia;
    fecha_hora_entrega.text =
        widget.guiaCliente[widget.id].fecha_hora_entrega.toString();
    estado_cargo.text = widget.guiaCliente[widget.id].estado_cargo;
    fecha_cargo.text = widget.guiaCliente[widget.id].fecha_cargo.toString();

    recibido_por.text = widget.guiaCliente[widget.id].recibido_por;
    entregado_por.text = widget.guiaCliente[widget.id].entregado_por;
    observacion.text = widget.guiaCliente[widget.id].observacion;

    guardar() async {
      await _providerlista.editarGRClienteSeguimiento(
          id_guia_remision_cliente:
              widget.guiaCliente[widget.id].id_guia_remision_cliente,
          id_estado_cargo: widget.guiaCliente[widget.id].id_estado_cargo,
          recibido_por: recibido_por.text,
          entregado_por: entregado_por.text,
          id_estado_mercaderia:
              widget.guiaCliente[widget.id].id_estado_mercaderia,
          observacion: observacion.text,
          fecha_hora_entrega: fecha_hora_entrega.text,
          fecha_cargo: fecha_cargo.text);
      Navigator.of(context).pop();
      setState(() {});
    }

    DateTime nowtras = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDatetras = formatter.format(nowtras);

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
                        SizedBox(height: 10.0),
                        Flexible(
                            child: new Row(
                          children: [
                            Flexible(
                              child: new TextField(
                                cursorColor: Colors.blueAccent,
                                controller: guia_cliente,
                                obscureText: false,
                                onChanged: (x) {
                                  widget.guiaCliente[widget.id].guia_cliente =
                                      x;
                                },
                                keyboardType: TextInputType.text,
                                style: style,
                                enabled: false,
                                decoration: InputDecoration(
                                    fillColor: Colors.blueAccent,
                                    labelText: 'GR Cliente',
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    hintText: 'GR Cliente',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0))),
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Flexible(
                              child: new TextField(
                                cursorColor: Colors.blueAccent,
                                controller: ft,
                                enabled: false,
                                keyboardType: TextInputType.text,
                                obscureText: false,
                                onChanged: (x) {
                                  widget.guiaCliente[widget.id].ft = x;
                                },
                                style: style,
                                decoration: InputDecoration(
                                    fillColor: Colors.blueAccent,
                                    labelText: 'FT',
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    hintText: 'FT',
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
                                controller: oc,
                                enabled: false,
                                obscureText: false,
                                onChanged: (x) {
                                  widget.guiaCliente[widget.id].oc = x;
                                },
                                style: style,
                                decoration: InputDecoration(
                                    fillColor: Colors.blueAccent,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    hintText: 'OC',
                                    labelText: 'OC',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0))),
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Flexible(
                              child: new TextField(
                                cursorColor: Colors.blueAccent,
                                controller: tipo_carga,
                                enabled: false,
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                style: style,
                                onChanged: (x) {
                                  widget.guiaCliente[widget.id].tipo_carga = x;
                                },
                                decoration: InputDecoration(
                                    fillColor: Colors.blueAccent,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    hintText: 'TIPO',
                                    labelText: 'TIPO',
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
                          controller: descripcion,
                          obscureText: false,
                          enabled: false,
                          onChanged: (x) {
                            widget.guiaCliente[widget.id].descripcion = (x);
                          },
                          keyboardType: TextInputType.number,
                          style: style,
                          decoration: InputDecoration(
                              fillColor: Colors.blueAccent,
                              labelText: 'Descripcion',
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: 'Descripcion',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          padding: EdgeInsets.all(0),
                          child: TypeAheadField<Estados>(
                            hideSuggestionsOnKeyboardHide: true,
                            debounceDuration: Duration(milliseconds: 500),
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: estado_mercaderia,
                              decoration: InputDecoration(
                                  labelText: 'Estado Mercaderia',
                                  fillColor: Color(0xFF3949AB),
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  hintText: 'Estado Mercaderia',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  hoverColor: Color(0xFF3949AB),
                                  focusColor: Color(0xFF3949AB)),
                            ),
                            suggestionsCallback: ProviderLista.get_estados,
                            itemBuilder: (context, Estados suggestion) {
                              final user = suggestion;

                              return ListTile(
                                title: Text(user.nombre_estado),
                              );
                            },
                            noItemsFoundBuilder: (context) => Container(
                              height: 100,
                              child: Center(
                                child: Text(
                                  'No Estado',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                            onSuggestionSelected: (Estados suggestion) {
                              setState(() {
                                widget.guiaCliente[widget.id]
                                        .estado_mercaderia =
                                    suggestion.nombre_estado;
                                widget.guiaCliente[widget.id]
                                        .id_estado_mercaderia =
                                    suggestion.id_estado;
                                'select'
                                    .replaceAll('', suggestion.nombre_estado);
                              });
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(SnackBar(
                                    content: Text('${suggestion.id_estado}')));
                            },
                          ),
                        ),
                        SizedBox(height: 10.0),

                        ///
                        ////
                        TextField(
                          cursorColor: Colors.blueAccent,
                          controller: fecha_hora_entrega,
                          obscureText: false,
                          style: style,
                          decoration: InputDecoration(
                              labelText: 'Fecha Entrega',
                              fillColor: Colors.blueAccent,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: 'Fecha Entrega',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          onTap: () async {
                            DateTime pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2050));

                            if (pickedDate != null && pickedDate != currentDate)
                              setState(() {
                                currentDate = pickedDate;
                                fecha_hora_entrega.text = pickedDate.toString();

                                widget.guiaCliente[widget.id]
                                        .fecha_hora_entrega =
                                    formatter.format(pickedDate);
                              });
                          },
                        ),
                        //
                        SizedBox(height: 10.0),
                        Container(
                          padding: EdgeInsets.all(0),
                          child: TypeAheadField<Estados>(
                            hideSuggestionsOnKeyboardHide: true,
                            debounceDuration: Duration(milliseconds: 500),
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: estado_cargo,
                              decoration: InputDecoration(
                                  labelText: 'Estado Cargo',
                                  fillColor: Color(0xFF3949AB),
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  hintText: 'Estado Cargo',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  hoverColor: Color(0xFF3949AB),
                                  focusColor: Color(0xFF3949AB)),
                            ),
                            suggestionsCallback: ProviderLista.get_estados,
                            itemBuilder: (context, Estados suggestion) {
                              final user = suggestion;

                              return ListTile(
                                title: Text(user.nombre_estado),
                              );
                            },
                            noItemsFoundBuilder: (context) => Container(
                              height: 100,
                              child: Center(
                                child: Text(
                                  'No Estado',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                            onSuggestionSelected: (Estados suggestion) {
                              setState(() {
                                widget.guiaCliente[widget.id].estado_cargo =
                                    suggestion.nombre_estado;
                                widget.guiaCliente[widget.id].id_estado_cargo =
                                    suggestion.id_estado;
                                'select'
                                    .replaceAll('', suggestion.nombre_estado);
                              });
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(SnackBar(
                                    content: Text('${suggestion.id_estado}')));
                            },
                          ),
                        ),
                        SizedBox(height: 10.0),

                        TextField(
                          cursorColor: Colors.blueAccent,
                          controller: fecha_cargo,
                          obscureText: false,
                          style: style,
                          decoration: InputDecoration(
                              labelText: 'Fecha Cargo',
                              fillColor: Colors.blueAccent,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: 'Fecha Cargo',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          onTap: () async {
                            DateTime pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2050));

                            if (pickedDate != null && pickedDate != currentDate)
                              setState(() {
                                currentDate = pickedDate;
                                fecha_cargo.text = pickedDate.toString();

                                widget.guiaCliente[widget.id].fecha_cargo =
                                    formatter.format(pickedDate);
                              });
                          },
                        ),
                        //

                        SizedBox(height: 10.0),
                        new TextField(
                          cursorColor: Colors.blueAccent,
                          controller: recibido_por,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          style: style,
                          onChanged: (x) {
                            widget.guiaCliente[widget.id].recibido_por = x;
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.blueAccent,
                              labelText: 'Recibido por',
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: 'Recibido por',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                        SizedBox(height: 10.0),
                        new TextField(
                          cursorColor: Colors.blueAccent,
                          controller: entregado_por,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          style: style,
                          onChanged: (x) {
                            widget.guiaCliente[widget.id].entregado_por = x;
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.blueAccent,
                              labelText: 'Entregado por',
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: 'Entregado por',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                        SizedBox(height: 10.0),
                        new TextField(
                          cursorColor: Colors.blueAccent,
                          controller: observacion,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          style: style,
                          onChanged: (x) {
                            widget.guiaCliente[widget.id].observacion = x;
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.blueAccent,
                              labelText: 'Observacion',
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: 'Observacion',
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
