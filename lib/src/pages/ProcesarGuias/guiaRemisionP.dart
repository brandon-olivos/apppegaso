import 'dart:convert';
import 'dart:io';
import 'package:Pegaso/src/Pages/Asignaciones/detalleguia/Detalleguiaed.dart';
import 'package:Pegaso/src/data/db/token.dart';
import 'package:Pegaso/src/data/models/TipoViaCarga.dart';
import 'package:Pegaso/src/data/models/Via.dart';
import 'package:Pegaso/src/data/models/agente.dart';
import 'package:Pegaso/src/data/models/direccion.dart';
import 'package:Pegaso/src/data/models/entidades.dart';
import 'package:Pegaso/src/data/models/guiaCliente.dart';
import 'package:Pegaso/src/data/models/guia_rem_cliente_m.dart';
import 'package:Pegaso/src/data/models/listaGuiasPend.dart';
import 'package:Pegaso/src/data/provider/TraerToken.dart';
import 'package:Pegaso/src/data/provider/provider.dart';
import 'package:Pegaso/src/data/provider/providerProcesarGuias.dart';
import 'package:Pegaso/src/pages/ProcesarGuias/Guiacliente/CrearGuiaClientePage.dart';
import 'package:Pegaso/src/pages/ProcesarGuias/Guiacliente/EdtitarGuiaClientePage.dart';
import 'package:Pegaso/src/pages/ProcesarGuias/Guiacliente/tablaGcliente.dart';
import 'package:Pegaso/src/util/app-config.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class GuiaRemisionP extends StatefulWidget {
  ListaGuiasPend guiapen;
  OnInvokeCallback s;
  GuiaRemisionP({s, this.guiapen});

  static String route = '/';

  @override
  _GuiaRemisionPState createState() => _GuiaRemisionPState();
}

class _GuiaRemisionPState extends State<GuiaRemisionP> {
  final _providerGuias = new ProviderProcesarGuias();

  @override
  // ignore: must_call_super
  void initState() {
    super.initState();
    //widget.s.call(op());

    setState(() {
      //  _providerGuias.getListaGuiasCliente(widget.guiapen.idGuiaRemision);
    });
  }

  TextEditingController fechainicio = TextEditingController();
  TextEditingController traslado = TextEditingController();
  TextEditingController remitente = TextEditingController();
  TextEditingController agente = TextEditingController();
  TextEditingController destinatario = TextEditingController();
  TextEditingController direccionDestino = TextEditingController();
  final _provider = new Provider();

  var _image, _imageby;
  String image64;
  bool loading = true;

  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<Direccion>> key = new GlobalKey();
  static List<Direccion> loadUsers(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Direccion>((json) => Direccion.fromJson(json)).toList();
  }

  var formatter = new DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    //_providerGuias.getListaGuiasCliente(widget.guiapen.idGuiaRemision);

    direccionDestino.text = widget.guiapen.direccion_llegada;
    agente.text = widget.guiapen.agente;
    fechainicio.text = widget.guiapen.fecha;
    traslado.text = widget.guiapen.fechaTraslado;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.guiapen.nmSolicitud),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.indigo[900],
        actions: [
          IconButton(
            icon: Icon(Icons.document_scanner),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CrearGuiaClientePage(
                          id: int.parse(
                            widget.guiapen.idGuiaRemision,
                          ),
                        )),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            cameraImage();
          },
          child: const Icon(Icons.camera),
          backgroundColor: Colors.orange),
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
                  fecha('Fecha'),
                  SizedBox(height: 10.0),
                  fechaTraslado('Fecha Traslado'),
                  SizedBox(height: 10.0),
                seleccionarVia(),
                  SizedBox(height: 10.0),
                 seleccionarTV(),
                  SizedBox(height: 10.0),
                  imputFielAgente('Agente'),
                  SizedBox(height: 10.0),
                  imputFielDestinatario('Destinatario'),
                  SizedBox(height: 10.0),
                  imputDLlegada('Direccion Llegada'),
                  SizedBox(height: 5.0),
                  //    agregarGuiaCliente(),
                  //   SizedBox(height: 10.0),
                  TablaGiaClientePro(
                      title: '',
                      idGuiaRemision: int.parse(widget.guiapen.idGuiaRemision)),
                  SizedBox(height: 20.0),
                  guardarG(),
                  SizedBox(height: 10.0),
                  cancelar(),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  fecha(fechatext) {
    return TextField(
      cursorColor: Colors.blueAccent,
      controller: fechainicio,
      obscureText: false,
      style: _providerGuias.style,
      decoration: InputDecoration(
          labelText: fechatext,
          fillColor: Colors.blueAccent,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: fechatext,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      onTap: () async {
        _providerGuias.nowfec = await showDatePicker(
            context: context,
            initialDate: _providerGuias.nowfec,
            firstDate: DateTime(1900),
            lastDate: DateTime(2100));

        setState(() {
          widget.guiapen.fecha = formatter.format(_providerGuias.nowfec);
        });
      },
    );
  }

  fechaTraslado(fexc) {
    return TextField(
      cursorColor: Colors.blueAccent,
      controller: traslado,
      obscureText: false,
      style: _providerGuias.style,
      onChanged: (val) {},
      decoration: InputDecoration(
          labelText: fexc,
          fillColor: Colors.blueAccent,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: fexc,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      onTap: () async {
        FocusScope.of(context).requestFocus(new FocusNode());

        _providerGuias.nowtras = await showDatePicker(
            context: context,
            initialDate: _providerGuias.nowtras,
            firstDate: DateTime(1900),
            lastDate: DateTime(2100));

        setState(() {
          widget.guiapen.fechaTraslado =
              formatter.format(_providerGuias.nowtras);
        });
      },
    );
  }

  agregarGuiaCliente() {
    return Material(
      elevation: 10.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.blue[900],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CrearGuiaClientePage(
                      id: int.parse(
                        widget.guiapen.idGuiaRemision,
                      ),
                    )),
          );
        },
        child: Text("Detalle GRC",
            textAlign: TextAlign.center,
            style: _providerGuias.style.copyWith(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  Future cameraImage() async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 700);
    setState(() {
      _imageby = image.path;
      _image = image;
    });
    List<int> bytes = await new File(_imageby).readAsBytesSync();
    image64 = base64Encode(bytes);
  }

  imputFielDestinatario(
    texto,
  ) {
    destinatario.text = widget.guiapen.destinatario;
    return Container(
      padding: EdgeInsets.all(0),
      child: TypeAheadField<Entidad>(
        hideSuggestionsOnKeyboardHide: true,
        debounceDuration: Duration(milliseconds: 500),
        textFieldConfiguration: TextFieldConfiguration(
          controller: destinatario,
          decoration: InputDecoration(
              labelText: texto,
              fillColor: Color(0xFF3949AB),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: widget.guiapen.destinatario,
              // suffixText: textAuxiliar,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              hoverColor: Color(0xFF3949AB),
              focusColor: Color(0xFF3949AB)),
        ),
        suggestionsCallback: ProviderProcesarGuias.getEndidadSugPen,
        itemBuilder: (context, Entidad suggestion) {
          final user = suggestion;

          return ListTile(
            title: Text(user.razon_social),
          );
        },
        noItemsFoundBuilder: (context) => Container(
          height: 100,
          child: Center(
            child: Text(
              'No Destinatario',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
        onSuggestionSelected: (Entidad suggestion) {
          setState(() {
            widget.guiapen.destinatario = suggestion.razon_social;
            destinatario.text = widget.guiapen.destinatario;
            widget.guiapen.id_destinatario = suggestion.id_entidad.toString();
            widget.guiapen.direccion_llegada = '';
            widget.guiapen.destinatario.replaceAll('', suggestion.razon_social);
            // _providerGuias.getDireccionllegada(widget.idDestinatario);
          });
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('${suggestion.id_entidad}')));
        },
      ),
    );
  }

  imputDLlegada(texto) {
    return Container(
      padding: EdgeInsets.all(0),
      child: TypeAheadField<Direccion>(
        hideSuggestionsOnKeyboardHide: false,
        debounceDuration: Duration(milliseconds: 500),
        textFieldConfiguration: TextFieldConfiguration(
          controller: direccionDestino,
          decoration: InputDecoration(
            labelText: texto,
            fillColor: Color(0xFF3949AB),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: texto,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        suggestionsCallback: getDSuggestions,
        itemBuilder: (context, Direccion suggestion) {
          final user = suggestion;

          return ListTile(
            title: Text(user.direccion),
          );
        },
        noItemsFoundBuilder: (context) => Container(
          height: 100,
          child: Center(
            child: Text(
              'No auxiliar',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        onSuggestionSelected: (Direccion suggestion) {
          final user = suggestion;
          setState(() {
            widget.guiapen.direccion_llegada = user.direccion;
            widget.guiapen.id_direccion_llegada = user.id_direccion.toString();
          });
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('${user.direccion}')));
        },
      ),
    );
  }

  imputFielAgente(texto) {
    return Container(
      padding: EdgeInsets.all(0),
      child: TypeAheadField<Agente>(
        hideSuggestionsOnKeyboardHide: true,
        debounceDuration: Duration(milliseconds: 500),
        textFieldConfiguration: TextFieldConfiguration(
          controller: agente,
          decoration: InputDecoration(
              labelText: texto,
              fillColor: Color(0xFF3949AB),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: texto,
              // suffixText: textAuxiliar,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              hoverColor: Color(0xFF3949AB),
              focusColor: Color(0xFF3949AB)),
        ),
        suggestionsCallback: ProviderProcesarGuias.getUserSuggestions,
        itemBuilder: (context, Agente suggestion) {
          final user = suggestion;

          return ListTile(
            title: Text(user.cuenta),
          );
        },
        noItemsFoundBuilder: (context) => Container(
          height: 100,
          child: Center(
            child: Text(
              'No agente',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
        onSuggestionSelected: (Agente suggestion) {
          setState(() {
            widget.guiapen.agente = suggestion.cuenta;

            agente.text = widget.guiapen.agente;

            widget.guiapen.id_agente = suggestion.idAgente.toString();
            widget.guiapen.agente.replaceAll('', suggestion.cuenta);
          });
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('${suggestion.idAgente}')));
        },
      ),
    );
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
          await _providerGuias.editarGuia(
              fecha: widget.guiapen.fecha,
              traslado: widget.guiapen.fechaTraslado,
              agente: widget.guiapen.id_agente,
              via: widget.guiapen.idVia,
              via_tipo: widget.guiapen.id_tipo_via,
              destinatario: widget.guiapen.id_destinatario,
              direccion_llegada: widget.guiapen.id_direccion_llegada,
              id_guia_rem: widget.guiapen.idGuiaRemision,

              // id_atencion_pedido: widget.guiapen.,
              imagen: image64);

          setState(() {});
          Navigator.of(context).pop();
          //   LoginUser(email.text, password.text);
        },
        child: Text("Guardar",
            textAlign: TextAlign.center,
            style: _providerGuias.style.copyWith(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  seleccionarVia() {
    return Container(
      child: FutureBuilder<List<Via>>(
        future: _provider.getVia(),
        builder: (BuildContext context, AsyncSnapshot<List<Via>> snapshot) {
          Via depatalits;

          if (!snapshot.hasData) {
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
                child: DropdownButton<Via>(
                  //  icon: Icon(Icons.ac_unit_rounded),

                  underline: SizedBox(),
                  isExpanded: true,
                  items: snapshot.data
                      .map((user) => DropdownMenuItem<Via>(
                            child: Text(user.nombreVia),
                            value: user,
                          ))
                      .toList(),
                  onChanged: (Via newVal) async {
                    await _provider.getTipoViaCarga(newVal.idVia);

                    setState(() {
                      depatalits = newVal;
                      widget.guiapen.idVia = newVal.idVia.toString();
                      widget.guiapen.tipo_via_carga = 'Seleccionar Tipo Via';
                      widget.guiapen.via = newVal.nombreVia;
                    });
                  },
                  value: depatalits,
                  hint: Text("  ${widget.guiapen.via}"),
                ));
          }
        },
      ),
    );
  }

  seleccionarTV() {
    return Container(
      child: FutureBuilder<List<TipoViaCarga>>(
        future: _provider.getTipoViaCarga(int.parse(widget.guiapen.idVia)),
        builder:
            (BuildContext context, AsyncSnapshot<List<TipoViaCarga>> snapshot) {
          TipoViaCarga depatalits;
          if (!snapshot.hasData) {
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
                child: DropdownButton<TipoViaCarga>(
                  //  icon: Icon(Icons.ac_unit_rounded),

                  underline: SizedBox(),
                  isExpanded: true,
                  items: snapshot.data
                      .map((user) => DropdownMenuItem<TipoViaCarga>(
                            child: Text(user.tipo_via_carga),
                            value: user,
                          ))
                      .toList(),
                  onChanged: (TipoViaCarga newVal) {
                    setState(() {
                      depatalits = newVal;
                      widget.guiapen.tipo_via_carga = newVal.tipo_via_carga;

                      widget.guiapen.id_tipo_via =
                          newVal.id_tipo_via_carga.toString();
                    });
                  },
                  value: depatalits,
                  hint: Text(" ${widget.guiapen.tipo_via_carga}"),
                ));
          }
        },
      ),
    );
  }

  cancelar() {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Text("cancelar",
            textAlign: TextAlign.center,
            style: _providerGuias.style.copyWith(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  Future<List<Direccion>> getDSuggestions(String query) async {
    TraerToken().mostrarDatos();
    final url = Uri.parse(
      AppConfig.urlBackendMovil + '/atenderasignaciones/rest/direccion',
    );

    final response = await http.post(url,
        body: '{ "entidad":${widget.guiapen.id_destinatario}} ',
        headers: TraerToken.headers);
    print(response);
    if (response.statusCode == 200) {
      final List users = json.decode(response.body);

      return users.map((json) => Direccion.fromJson(json)).where((user) {
        final nameLower = user.direccion.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
