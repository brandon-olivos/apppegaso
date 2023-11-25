import 'package:Pegaso/src/Pages/GuiaRemAuxiliar/Actions/GuiaCliente/crearGuiaCliente.dart';
import 'package:Pegaso/src/Pages/GuiaRemAuxiliar/Actions/GuiaCliente/tablaGcliente.dart';
import 'package:Pegaso/src/data/db/token.dart';
import 'package:Pegaso/src/data/models/GuiaRemAux.dart';
import 'package:Pegaso/src/data/models/TipoViaCarga.dart';
import 'package:Pegaso/src/data/models/Via.dart';
import 'package:Pegaso/src/data/models/agente.dart';
import 'package:Pegaso/src/data/models/conductor.dart';
import 'package:Pegaso/src/data/models/direccion.dart';
import 'package:Pegaso/src/data/models/entidades.dart';
import 'package:Pegaso/src/data/models/transportista.dart';
import 'package:Pegaso/src/data/models/vehiculo.dart';
import 'package:Pegaso/src/data/provider/ProviderAsignacion.dart';
import 'package:Pegaso/src/data/provider/ProviderGuiasAuxiliar.dart';
import 'package:Pegaso/src/data/provider/TraerToken.dart';
import 'package:Pegaso/src/data/provider/provider.dart';
import 'package:Pegaso/src/data/provider/providerProcesarGuias.dart';
import 'package:Pegaso/src/util/app-config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class EditarGuiaRemAuxiliarPage extends StatefulWidget {
  final int guiRempegaso;

  EditarGuiaRemAuxiliarPage({this.guiRempegaso = 0});

  @override
  State<EditarGuiaRemAuxiliarPage> createState() =>
      _EditarGuiaRemAuxiliarPageState();
}

class _EditarGuiaRemAuxiliarPageState extends State<EditarGuiaRemAuxiliarPage> {
  final PageController _pageController = PageController();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController fechainicio = TextEditingController();
  TextEditingController traslado = TextEditingController();
  TextEditingController serie = TextEditingController();
  TextEditingController numeroGuia = TextEditingController();
  TextEditingController agente = TextEditingController();
  TextEditingController remitente = TextEditingController();
  TextEditingController direccionRem = TextEditingController();
  TextEditingController destinatario = TextEditingController();
  TextEditingController direccionPartida = TextEditingController();
  TextEditingController direccionDestino = TextEditingController();
  TextEditingController conductor = TextEditingController();
  TextEditingController vehiculo = TextEditingController();
  TextEditingController transportista = TextEditingController();
  TextEditingController guiaRemtransportista = TextEditingController();
  TextEditingController facturaTransportista = TextEditingController();
  TextEditingController importeTransportista = TextEditingController();
  TextEditingController comentarioTransportista = TextEditingController();
  DateTime currentDate = DateTime.now();
  final _providerAsignacion = new ProviderGuiasAuxiliar();
  final _provider = new Provider();
  var selectV = "SELECIONAR VIA";
  var selectTv = "Tipo Via";
  var idVia = 0;

  var idAgente = 0;
  var idEntida = 0;
  var dato;
  var tamanioboton = 50.0;

  GuiaRemAux _guiaRemAux = GuiaRemAux();

  Future refreshList() async {
    print(widget.guiRempegaso);
    await Future.delayed(Duration(seconds: 1));
    var a = await _providerAsignacion.getGuiaAuxiliar(widget.guiRempegaso);
    setState(() {
      _guiaRemAux = a;
      print(_guiaRemAux.idGuiaRemision);
    });
  }

  Map<String, String> get headers {
    //tokenUsuario.toMap(DatabasePr.db.getUltimoToken());

    return {
      // TODO: TOKEN DEL SQLITE

      // ignore: unnecessary_brace_in_string_interps
      "Authorization": "Bearer $dato",
      'Content-Type': 'application/json'
    };
  }

  @override
  void initState() {
    // TODO: implement initState
    refreshList();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  DateTime nowtras = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    fechainicio.text = _guiaRemAux.fecha.toString();
    traslado.text = _guiaRemAux.fechaTraslado.toString();
    serie.text = _guiaRemAux.serie;
    numeroGuia.text = _guiaRemAux.numeroGuia;
    agente.text = _guiaRemAux.agente;
    remitente.text = _guiaRemAux.remitente;
    direccionPartida.text = _guiaRemAux.direccionPartida;
    direccionDestino.text = _guiaRemAux.direccionLlegada;
    destinatario.text = _guiaRemAux.destinatario;
    conductor.text = _guiaRemAux.conductor;
    vehiculo.text = _guiaRemAux.vehiculo;
    transportista.text = _guiaRemAux.transportista;
    guiaRemtransportista.text = _guiaRemAux.guiaRemisionTransportista;
    facturaTransportista.text = _guiaRemAux.facturaTransportista;
    importeTransportista.text = _guiaRemAux.importeTransportista.toString();
    comentarioTransportista.text = _guiaRemAux.comentarioTransportista;
    if (_guiaRemAux.nombreEstado == 'ENTREGADO') {
      tamanioboton = 0.0;
    } else {
      print(_guiaRemAux.nombreEstado);
    }
//    String formattedDate = _guiaRemAux.fecha;
    String formattedDatetras = formatter.format(nowtras);

    return Scaffold(
      appBar: AppBar(
        title: Text('Guia ${_guiaRemAux.serie} - ${_guiaRemAux.numeroGuia}'),
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
                    builder: (context) => CrearGuiaCliente(
                          id: widget.guiRempegaso,
                        )),
              );
            },
          ),
        ],
      ),
      /* floatingActionButton: FloatingActionButton(
          onPressed: () {
            //cameraImage();
          },
          child: const Icon(Icons.camera),
          backgroundColor: Colors.orange), */
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
                  SizedBox(height: 5.0),
                  Flexible(
                      child: new Row(
                    children: [
                      Flexible(
                        child: fecha('Fecha'),
                      ),
                      SizedBox(width: 10.0),
                      Flexible(
                        child:
                            fechaTraslado('Fecha Traslado', formattedDatetras),
                      ),
                    ],
                  )),
                  SizedBox(height: 10.0),
                  Flexible(
                      child: new Row(
                    children: [
                      Flexible(
                        child: new TextField(
                          enabled: false,
                          cursorColor: Colors.blueAccent,
                          obscureText: false,
                          controller: serie,
                          keyboardType: TextInputType.text,
                          style: style,
                          decoration: InputDecoration(
                              fillColor: Colors.blueAccent,
                              labelText: 'GR Serie',
                              hintText: 'GR Serie',
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Flexible(
                        child: new TextField(
                          enabled: false,
                          cursorColor: Colors.blueAccent,
                          keyboardType: TextInputType.text,
                          controller: numeroGuia,
                          obscureText: false,
                          style: style,
                          decoration: InputDecoration(
                              labelText: 'GR Numero',
                              fillColor: Colors.blueAccent,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: 'GR Numero',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                      ),
                    ],
                  )),
                  SizedBox(height: 10.0),
                  Flexible(
                      child: new Row(
                    children: [
                      Flexible(
                        child: seleccionarVia(),
                      ),
                      SizedBox(width: 10.0),
                      Flexible(
                        child: seleccionarTV(),
                      ),
                    ],
                  )),
                  SizedBox(height: 10.0),
                  imputFields('Agente', agente),
                  SizedBox(height: 10.0),
                  imputRemitente('Remitente', remitente),
                  SizedBox(height: 10.0),
                  imputDpartida('Direccion Partida'),
                  SizedBox(height: 10.0),
                  imputDestinatario('Destinatario', destinatario),
                  SizedBox(height: 10.0),
                  imputDdestino('Direccion Llegada'),
                  SizedBox(height: 10.0),
                  imputConductor('Conductor', conductor),
                  SizedBox(height: 10.0),
                  imputVehiculo('Vehiculo', vehiculo),
                  SizedBox(height: 10.0),
                  imputTransportista('Tranportista', transportista),
                  SizedBox(height: 10.0),
                  guiatrsportista(),
                  SizedBox(height: 10.0),
                  importetranspot(),
                  SizedBox(height: 10.0),
                  comentariotrs(),
                  SizedBox(height: 10.0),
                  TablaGiaCliente(idGuiaRemision: widget.guiRempegaso),
                  SizedBox(height: 12.0),
                  SizedBox(child: guardarG()),

                  SizedBox(height: 10.0),
                  //cancelar(),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  comentariotrs() {
    return TextField(
      cursorColor: Colors.blueAccent,
      keyboardType: TextInputType.text,
      obscureText: false,
      style: style,
      onChanged: (x) {
        _guiaRemAux.comentarioTransportista = x;
      },
      controller: comentarioTransportista,
      decoration: InputDecoration(
          labelText: 'Comentario',
          fillColor: Colors.blueAccent,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Comentario',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
  }

  importetranspot() {
    return TextField(
      cursorColor: Colors.blueAccent,
      keyboardType: TextInputType.number,
      obscureText: false,
      style: style,
      onChanged: (x) {
        _guiaRemAux.importeTransportista = x.toString();
      },
      controller: importeTransportista,
      decoration: InputDecoration(
          labelText: 'Importe',
          fillColor: Colors.blueAccent,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Importe',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
  }

  guiatrsportista() {
    return Flexible(
        child: new Row(
      children: [
        Flexible(
          child: new TextField(
            cursorColor: Colors.blueAccent,
            obscureText: false,
            controller: guiaRemtransportista,
            onChanged: (x) {
              _guiaRemAux.guiaRemisionTransportista = x;
            },
            keyboardType: TextInputType.text,
            style: style,
            decoration: InputDecoration(
                fillColor: Colors.blueAccent,
                labelText: 'Guia Remision TR',
                hintText: 'Guia Remision TR',
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
          ),
        ),
        SizedBox(width: 5.0),
        Flexible(
          child: new TextField(
            cursorColor: Colors.blueAccent,
            keyboardType: TextInputType.text,
            obscureText: false,
            controller: facturaTransportista,
            style: style,
            onChanged: (x) {
              _guiaRemAux.facturaTransportista = x;
            },
            decoration: InputDecoration(
                labelText: 'Factura',
                fillColor: Colors.blueAccent,
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: 'Factura',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
          ),
        ),
      ],
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
          await _providerAsignacion.editarGuiaRMAux(
            id_guia_remision: _guiaRemAux.idGuiaRemision,
            serie: _guiaRemAux.serie,
            numero_guia: _guiaRemAux.numeroGuia,
            fecha: _guiaRemAux.fecha,
            fecha_traslado: _guiaRemAux.fechaTraslado,
            id_via: _guiaRemAux.idVia,
            id_tipo_via: _guiaRemAux.idTipoVia,
            // id_cliente: _guiaRemAux.idCliente,
            id_agente: _guiaRemAux.idAgente,
            id_remitente: _guiaRemAux.idRemitente,
            id_direccion_partida: _guiaRemAux.idDireccionPartida,
            id_destinatario: _guiaRemAux.idDestinatario,
            id_direccion_llegada: _guiaRemAux.idDireccionLlegada,
            id_conductor: _guiaRemAux.idConductor,
            id_vehiculo: _guiaRemAux.idVehiculo,
            transportista: _guiaRemAux.idTransportista,
            guia_remision_transportista: _guiaRemAux.guiaRemisionTransportista,
            factura_transportista: _guiaRemAux.facturaTransportista,
            importe_transportista: _guiaRemAux.importeTransportista,
            comentario_transportista: _guiaRemAux.comentarioTransportista,

            // id_atencion_pedido: widget.guiapen.,
            //imagen: image64
          );

          setState(() {});
          Navigator.of(context).pop();
          //   LoginUser(email.text, password.text);
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

  fecha(fechatext) {
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
        final DateTime pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.parse(_guiaRemAux.fecha),
            firstDate: DateTime(2015),
            lastDate: DateTime(2050));
        print(pickedDate);
        if (pickedDate != null && pickedDate != currentDate)
          setState(() {
            currentDate = pickedDate;
            fechainicio.text = pickedDate.toString();

            _guiaRemAux.fecha = formatter.format(pickedDate);
          });
      },
    );
  }

  fechaTraslado(fechatext, varFecha) {
    return TextField(
      cursorColor: Colors.blueAccent,
      controller: traslado,
      obscureText: false,
      style: style,
      onChanged: (val) {
        setState(() {
          varFecha = val;
        });
      },
      decoration: InputDecoration(
          labelText: fechatext,
          fillColor: Colors.blueAccent,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: fechatext,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      onTap: () async {
        FocusScope.of(context).requestFocus(new FocusNode());

        final DateTime pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.parse(_guiaRemAux.fechaTraslado),
            firstDate: DateTime(2015),
            lastDate: DateTime(2050));
        print(pickedDate);
        if (pickedDate != null && pickedDate != currentDate)
          setState(() {
            currentDate = pickedDate;
            traslado.text = pickedDate.toString();

            _guiaRemAux.fechaTraslado = formatter.format(pickedDate);
          });
      },
    );
  }

  seleccionarVia() {
    return Container(
      child: FutureBuilder<List<Via>>(
        future: _providerAsignacion.getVia(),
        builder: (BuildContext context, AsyncSnapshot<List<Via>> snapshot) {
          Via depatalits;

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
            // refreshList();
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
                    await _providerAsignacion.getTipoViaCarga(newVal.idVia);

                    setState(() {
                      depatalits = newVal;
                      _guiaRemAux.idVia = newVal.idVia.toString();

                      _guiaRemAux.nombreVia = newVal.nombreVia;

                      // valorheig = 50.0;
                    });
                  },
                  value: depatalits,
                  hint: Text("   ${_guiaRemAux.nombreVia}"),
                ));
          }
        },
      ),
    );
  }

  seleccionarTV() {
    return Container(
      child: FutureBuilder<List<TipoViaCarga>>(
        future: _providerAsignacion.getTipoViaCarga(_guiaRemAux.idVia),
        builder:
            (BuildContext context, AsyncSnapshot<List<TipoViaCarga>> snapshot) {
          TipoViaCarga depatalits;
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

          if (listaPersonalAux?.length == 0) {
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
                      _guiaRemAux.tipoViaCarga = newVal.tipo_via_carga;
                      _guiaRemAux.idTipoVia =
                          newVal.id_tipo_via_carga.toString();
                    });
                  },
                  value: depatalits,
                  hint: Text("   ${_guiaRemAux.tipoViaCarga}"),
                ));
          }
        },
      ),
    );
  }

  agregarGuiaCliente() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.blue[900],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          /*  Navigator.push(
            context,CrearGuiaCliente
            MaterialPageRoute(builder: (context) => DetalleGuiaRmClPage()),
          ); */
        },
        child: Text("Detalle GRC",
            textAlign: TextAlign.center,
            style: style.copyWith(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  imputFields(textAuxiliar, controlador) {
    return Container(
      padding: EdgeInsets.all(0),
      child: TypeAheadField<Agente>(
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
        suggestionsCallback: ProviderAsignacion.getUserSuggestions,
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
              'No Agente',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
        onSuggestionSelected: (Agente suggestion) {
          setState(() {
            _guiaRemAux.agente = suggestion.cuenta;
            _guiaRemAux.idAgente = suggestion.idAgente.toString();
            textAuxiliar.replaceAll('', suggestion.cuenta);
          });
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('${suggestion.idAgente}')));
        },
      ),
    );
  }

  imputRemitente(textAuxiliar, controlador) {
    return Container(
      padding: EdgeInsets.all(0),
      child: TypeAheadField<Entidad>(
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
        suggestionsCallback: ProviderAsignacion.getEndidadSuggestions,
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
              'No Agente',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
        onSuggestionSelected: (Entidad suggestion) {
          setState(() {
            _guiaRemAux.remitente = suggestion.razon_social;
            _guiaRemAux.idRemitente = suggestion.id_entidad.toString();
            textAuxiliar.replaceAll('', suggestion.razon_social);
          });
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('${suggestion.id_entidad}')));
        },
      ),
    );
  }

  imputDpartida(texto) {
    return Container(
      padding: EdgeInsets.all(0),
      child: TypeAheadField<Direccion>(
        hideSuggestionsOnKeyboardHide: false,
        debounceDuration: Duration(milliseconds: 500),
        textFieldConfiguration: TextFieldConfiguration(
          controller: direccionPartida,
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
            _guiaRemAux.direccionPartida = suggestion.direccion;
            _guiaRemAux.idDireccionPartida = suggestion.id_direccion.toString();
          });
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('${user.direccion}')));
        },
      ),
    );
  }

  imputDdestino(texto) {
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
        suggestionsCallback: getDSuggestionsd,
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
            _guiaRemAux.direccionLlegada = suggestion.direccion;
            _guiaRemAux.idDireccionLlegada = suggestion.id_direccion.toString();
          });
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('${user.direccion}')));
        },
      ),
    );
  }

  imputDestinatario(textAuxiliar, controlador) {
    return Container(
      padding: EdgeInsets.all(0),
      child: TypeAheadField<Entidad>(
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
        suggestionsCallback: ProviderAsignacion.getEndidadSuggestions,
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
              'No Agente',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
        onSuggestionSelected: (Entidad suggestion) {
          setState(() {
            _guiaRemAux.destinatario = suggestion.razon_social;
            _guiaRemAux.idDestinatario = suggestion.id_entidad.toString();
            textAuxiliar.replaceAll('', suggestion.razon_social);
          });
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('${suggestion.id_entidad}')));
        },
      ),
    );
  }

  imputConductor(textAuxiliar, controlador) {
    return Container(
      padding: EdgeInsets.all(0),
      child: TypeAheadField<Conductor>(
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
        suggestionsCallback: ProviderGuiasAuxiliar.getDSuggestionsconductor,
        itemBuilder: (context, Conductor suggestion) {
          final user = suggestion;

          return ListTile(
            title: Text(user.empleado),
          );
        },
        noItemsFoundBuilder: (context) => Container(
          height: 100,
          child: Center(
            child: Text(
              'No Agente',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
        onSuggestionSelected: (Conductor suggestion) {
          setState(() {
            _guiaRemAux.conductor = suggestion.empleado;
            _guiaRemAux.idConductor = suggestion.idEmpleado.toString();
            textAuxiliar.replaceAll('', suggestion.empleado);
          });
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('${suggestion.idEmpleado}')));
        },
      ),
    );
  }

  imputVehiculo(textAuxiliar, controlador) {
    return Container(
      padding: EdgeInsets.all(0),
      child: TypeAheadField<Vehiculo>(
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
        suggestionsCallback: ProviderGuiasAuxiliar.getDSuggestionsvehiculo,
        itemBuilder: (context, Vehiculo suggestion) {
          final user = suggestion;

          return ListTile(
            title: Text(user.descripcion),
          );
        },
        noItemsFoundBuilder: (context) => Container(
          height: 100,
          child: Center(
            child: Text(
              'No Agente',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
        onSuggestionSelected: (Vehiculo suggestion) {
          setState(() {
            _guiaRemAux.vehiculo = suggestion.descripcion;
            _guiaRemAux.idVehiculo = suggestion.idVehiculo.toString();
            textAuxiliar.replaceAll('', suggestion.descripcion);
          });
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('${suggestion.idVehiculo}')));
        },
      ),
    );
  }

  imputTransportista(textAuxiliar, controlador) {
    return Container(
      padding: EdgeInsets.all(0),
      child: TypeAheadField<Transportista>(
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
        suggestionsCallback: ProviderGuiasAuxiliar.getDSuggestionstransportista,
        itemBuilder: (context, Transportista suggestion) {
          final user = suggestion;

          return ListTile(
            title: Text(user.razonSocial),
          );
        },
        noItemsFoundBuilder: (context) => Container(
          height: 100,
          child: Center(
            child: Text(
              'No Agente',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
        onSuggestionSelected: (Transportista suggestion) {
          setState(() {
            _guiaRemAux.transportista = suggestion.razonSocial;
            _guiaRemAux.idTransportista = suggestion.idTransportista.toString();
            textAuxiliar.replaceAll('', suggestion.razonSocial);
          });
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
                SnackBar(content: Text('${suggestion.idTransportista}')));
        },
      ),
    );
  }

  Future<List<Direccion>> getDSuggestions(String query) async {
    await TraerToken().mostrarDatos();
    final url = Uri.parse(
      AppConfig.urlBackendMovil + '/atenderasignaciones/rest/direccion',
    );

    final response = await http.post(url,
        body: '{ "entidad":${_guiaRemAux.idRemitente}} ',
        headers: TraerToken.headers);

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

  Future<List<Direccion>> getDSuggestionsd(String query) async {
    await TraerToken().mostrarDatos();
    final url = Uri.parse(
      AppConfig.urlBackendMovil + '/atenderasignaciones/rest/direccion',
    );

    final response = await http.post(url,
        body: '{ "entidad":${_guiaRemAux.idDestinatario}} ',
        headers: TraerToken.headers);

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
