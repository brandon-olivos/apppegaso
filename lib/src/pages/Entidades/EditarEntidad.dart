import 'package:Pegaso/src/data/models/TipoDocumento.dart';
import 'package:Pegaso/src/data/models/Ubigeos.dart';
import 'package:Pegaso/src/data/models/entidades.dart';
import 'package:Pegaso/src/data/provider/provider.dart';
import 'package:Pegaso/src/data/provider/providerEntidades.dart';
import 'package:Pegaso/src/pages/Direcciones/RegDirecciones.dart';
import 'package:Pegaso/src/pages/Entidades/CrearEntidad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditarEntidad extends StatefulWidget {
  Entidad entidad = Entidad();
  EditarEntidad({this.entidad});
  @override
  State<EditarEntidad> createState() => _EditarEntidadState();
}

class _EditarEntidadState extends State<EditarEntidad> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  TextEditingController numeroDocumento = TextEditingController();
  TextEditingController cliente = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController correo = TextEditingController();

  final _provider = new ProviderEntidades();

  int selelectIdTipoDocumento;

  String selectTipoDoc = "Seleccionar Tipo Documento ";
  TextEditingController direccion = TextEditingController();
  TextEditingController urbanizacion = TextEditingController();
  TextEditingController referencia = TextEditingController();
  TextEditingController ubigeos = TextEditingController();

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  cargarDatos() async {
    var idTdoc = await _provider.getTipoDocumentoPorId(widget.entidad);
    numeroDocumento.text = widget.entidad.numero_documento;
    cliente.text = widget.entidad.razon_social;
    telefono.text = widget.entidad.telefono;
    correo.text = widget.entidad.correo;
    selectTipoDoc = idTdoc[0].documento;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("EDITAR ENTIDAD"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.indigo[900],
        ),
        body: Center(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TiposDocumento(),
                    SizedBox(
                      height: 10.0,
                    ),
                    imputvalor(
                        hinttext: "Numero_documento",
                        label: "Numero_documento",
                        controller: numeroDocumento,
                        keyTipo: TextInputType.number,
                        onchanged: (v) {
                          widget.entidad.numero_documento = v.toString();
                          print(v);
                        }),
                    SizedBox(
                      height: 10.0,
                    ),
                    imputvalor(
                        hinttext: "razon_social",
                        label: "razon_social",
                        controller: cliente,
                        keyTipo: TextInputType.text,
                        onchanged: (v) {
                          widget.entidad.razon_social = v.toString();
                          print(v);
                        }),
                    SizedBox(
                      height: 10.0,
                    ),
                    imputvalor(
                        hinttext: "telefono",
                        label: "telefono",
                        controller: telefono,
                        keyTipo: TextInputType.phone,
                        onchanged: (v) {
                          widget.entidad.telefono = v.toString();
                          print(v);
                        }),
                    SizedBox(
                      height: 10.0,
                    ),
                    imputvalor(
                        hinttext: "correo",
                        label: "correo",
                        controller: correo,
                        keyTipo: TextInputType.emailAddress,
                        onchanged: (v) {
                          widget.entidad.correo = v.toString();
                          print(v);
                        }),
                    SizedBox(
                      height: 10.0,
                    ),
                    guardarG(),
                    SizedBox(height: 100.0),
                  ],
                ),
              ]),
            ),
          ),
        ));
  }

  guardarG() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.blue[900],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          var ar = await _provider.guardar(widget.entidad);
          if (ar == 200) {
            Fluttertoast.showToast(
              msg: 'Registro Correcto',
              gravity: ToastGravity.BOTTOM,
            );

            ///await Future.delayed(Duration(seconds: 2));
            Navigator.pop(context, 'OK');
          }
        },
        child: Text("Guardar",
            textAlign: TextAlign.center,
            style: style.copyWith(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  imputUbigeos(textAuxiliar, controlador) {
    return Container(
      padding: EdgeInsets.all(0),
      child: TypeAheadField<Ubigeos>(
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
        suggestionsCallback: Provider.getUbigeosSuggestions,
        itemBuilder: (context, Ubigeos suggestion) {
          final user = suggestion;

          return ListTile(
            title: Text(user.nombreDistrito),
          );
        },
        noItemsFoundBuilder: (context) => Container(
          height: 100,
          child: Center(
            child: Text(
              'No',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
        onSuggestionSelected: (Ubigeos suggestion) {
          setState(() {
            controlador.text = suggestion.nombreDistrito;

            ///  _listaDirecciones.idUbigeo = suggestion.idUbigeo.toString();
            textAuxiliar.replaceAll('', suggestion.nombreProvincia);
          });
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('${suggestion.idUbigeo}')));
        },
      ),
    );
  }

  TiposDocumento() {
    return Flexible(
        child: new Row(
      children: [
        Flexible(
          child: Container(
            child: FutureBuilder<List<TipoDocumento>>(
              future: _provider.getTipoDocumento(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<TipoDocumento>> snapshot) {
                TipoDocumento depatalits;

                if (snapshot.hasData) {
                  if (snapshot.hasData == false) {
                    return Center(
                      child: Text("¡No existen registros"),
                    );
                  } else {
                    final listaPersonalAux = snapshot.data;

                    if (listaPersonalAux.length == 0) {
                      return Center(
                        child: Text("No hay informacion"),
                      );
                    } else {
                      return Container(
                          decoration: Provider().myBoxDecoration(),
                          child: DropdownButton<TipoDocumento>(
                            //  icon: Icon(Icons.ac_unit_rounded),

                            underline: SizedBox(),
                            isExpanded: true,
                            items: snapshot.data
                                .map((user) => DropdownMenuItem<TipoDocumento>(
                                      child: Text(user.documento),
                                      value: user,
                                    ))
                                .toList(),
                            onChanged: (TipoDocumento newVal) async {
                              widget.entidad.id_tipo_documento =
                                  newVal.id_tipo_documento;
                              selectTipoDoc = newVal.documento;

                              setState(() {});
                            },

                            hint: Text("   $selectTipoDoc"),
                          ));
                    }
                  }
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ],
    ));
  }

  imputvalor({label, hinttext, controller, keyTipo, onchanged}) {
    return TextField(
      inputFormatters: [
        UpperCaseTextFormatter(),
      ],
      cursorColor: Colors.blueAccent,
      keyboardType: keyTipo,
      obscureText: false,
      style: style,
      controller: controller,
      onChanged: onchanged,
      decoration: InputDecoration(
          labelText: label,
          fillColor: Colors.blueAccent,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: hinttext,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
  }
}
