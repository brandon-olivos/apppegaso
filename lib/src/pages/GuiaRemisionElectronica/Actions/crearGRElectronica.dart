import 'package:Pegaso/src/data/models/GuiaRemAux.dart';
import 'package:Pegaso/src/data/models/TipoViaCarga.dart';
import 'package:Pegaso/src/data/models/Via.dart';
import 'package:Pegaso/src/data/models/agente.dart';
import 'package:Pegaso/src/data/models/conductor.dart';
import 'package:Pegaso/src/data/models/direccion.dart';
import 'package:Pegaso/src/data/models/entidades.dart';
import 'package:Pegaso/src/data/models/transportista.dart';
import 'package:Pegaso/src/data/models/vehiculo.dart';
import 'package:Pegaso/src/data/provider/TraerToken.dart';
import 'package:Pegaso/src/data/provider/provider.dart';
import 'package:Pegaso/src/data/provider/providerGRElectronica.dart';
import 'package:Pegaso/src/pages/Asignaciones/detalle_grc.dart';
import 'package:Pegaso/src/pages/Asignaciones/detalleguia/tablaGcliente.dart';
import 'package:Pegaso/src/util/app-config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:vibration/vibration.dart';
import 'package:Pegaso/src/data/db/token.dart';

class CrearGRElectronicaPage extends StatefulWidget {
  @override
  State<CrearGRElectronicaPage> createState() => _CrearGRElectronicaPageState();
}

class _CrearGRElectronicaPageState extends State<CrearGRElectronicaPage> {
  final PageController _pageController = PageController();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController fechainicio = TextEditingController();
  TextEditingController traslado = TextEditingController();
  TextEditingController agente = TextEditingController();
  TextEditingController remitente = TextEditingController();
  TextEditingController cliente = TextEditingController();
  TextEditingController direccionPartida = TextEditingController();
  TextEditingController direccionLlegado = TextEditingController();
  TextEditingController destinatario = TextEditingController();
  TextEditingController dllegada = TextEditingController();
  TextEditingController conductor = TextEditingController();
  TextEditingController vehiculo = TextEditingController();
  TextEditingController tranportista = TextEditingController();

  final _providerGRElectronica = new ProviderGRElectronica();

  GuiaRemAux _guiaRemAux = GuiaRemAux();
  final _provider = new Provider();
  var selectV = "Via";
  var selectTv = " Tipo Via";

  ////////
  var idVia_;
  var idTipoCarga_;

  var idCliente_;
  var idAgente_;

  var idRemitente_;
  var idDireccionPartida_;

  var idDestinatario_;
  var idDireccionLlegada_;

  var idConductor_;
  var idVehiculo_;

  var numeroGCliente_;

  var error_ = '';

  ///
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  DateTime nowfec = new DateTime.now();
  DateTime nowtras = new DateTime.now();
  DateTime currentDate = DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
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
                  SizedBox(height: 15.0),
                  fechaftras(),
                  //SizedBox(height: 10.0),
                  //serienumero(),

                  SizedBox(height: 15.0),

                  imputAgente('Agente', agente),
                  SizedBox(height: 15.0),
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
                  imputCliente('Cliente', cliente),
                  SizedBox(height: 15.0),
                  imputRemitente('Remitente', remitente),
                  SizedBox(height: 10.0),
                  imputDpartida('Direccion Partida'),
                  SizedBox(height: 10.0),
                  imputDestinatario('Destinatario', destinatario),
                  SizedBox(height: 10.0),
                  imputDllegada('Direccion Llegada'),
                  SizedBox(height: 10.0),
                  imputConductor('Conductor', conductor),
                  SizedBox(height: 10.0),
                  imputVehiculo('Vehiculo', vehiculo),
                  SizedBox(height: 10.0),
                  boton_AnadirGRC(),
                  SizedBox(height: 10.0),
                  //imputTransportista('Tranportista', tranportista),
                  //SizedBox(height: 10.0),
                  //guiaremfacttranspo(),
                  //SizedBox(height: 10.0),
                  //importetrans(),
                  //SizedBox(height: 10.0),
                  //comentariotrans(),
                  //SizedBox(height: 10.0),
                  TablaGiaClienteAsix(
                    title: '',
                  ),
                  SizedBox(height: 12.0),
                  boton_guardarG(),
                  SizedBox(height: 10.0),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  acction_guardar() async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Center(child: Text("Procesando Guia, espere")),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
          ),
        ],
      ),
    );

    await _providerGRElectronica.GuardarGuiaRMAux(guiaRemAux: _guiaRemAux);
    setState(() {});
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  boton_guardarG() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.blue[900],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          ///////////
          error_ = '';

          if (idVehiculo_ == null) {
            error_ = 'Ingrese Vehiculo';
          }
          if (idConductor_ == null) {
            error_ = 'Ingrese Conductor';
          }
          if (idDireccionLlegada_ == null) {
            error_ = 'Ingrese Direccion de Llegada';
          }
          if (idDestinatario_ == null) {
            error_ = 'Ingrese Destinatario';
          }
          if (idDireccionPartida_ == null) {
            error_ = 'Ingrese Direccion de Partida';
          }
          if (idRemitente_ == null) {
            error_ = 'Ingrese Remitente';
          }
          // if (idCliente_ == null) {
          //   error_ = 'Ingrese Cliente';
          // }
          if (idAgente_ == null) {
            error_ = 'Ingrese Agente';
          }
          if (idTipoCarga_ == null) {
            error_ = 'Ingrese Tipo de Carga';
          }

          if (idVia_ == null) {
            error_ = 'Ingrese Via';
          }

          /* var a = await DatabasePr.db.getDtaGRCjs();

          if (a == null) {
            error_ = 'Ingrese una Guia de Cliente';
          } */

          if (error_ == '') {
            ////////
            setState(() {
              acction_guardar();
            });
            /////////
          } else {
            setState(() {
              Vibration.vibrate(duration: 1000);
            });
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Center(child: Text(error_)),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
        child: Text("EMITIR GUIA ELECTRONICA",
            textAlign: TextAlign.center,
            style: style.copyWith(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
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
        suggestionsCallback: ProviderGRElectronica.getDSuggestionsvehiculo,
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
            controlador.text = suggestion.descripcion;
            _guiaRemAux.idVehiculo = suggestion.idVehiculo.toString();
            textAuxiliar.replaceAll('', suggestion.descripcion);
            idVehiculo_ = suggestion.idVehiculo.toString();
          });
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
                SnackBar(content: Text('${suggestion.descripcion}')));
        },
      ),
    );
  }

  fecha(fechatext) {
    String fecha_inicio = formatter.format(nowfec);

    _guiaRemAux.fecha = fechainicio.text;
    fechainicio.text = fecha_inicio;
    return TextField(
      enabled: false,
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
            initialDate: DateTime.parse('2023-01-01'),
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
        suggestionsCallback: ProviderGRElectronica.getDSuggestionstransportista,
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
            controlador.text = suggestion.razonSocial;
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

  fechaTraslado(fechatext) {
    String formattedDatetras = formatter.format(nowtras);
    _guiaRemAux.fechaTraslado = traslado.text;
    traslado.text = formattedDatetras;
    return TextField(
      enabled: false,
      cursorColor: Colors.blueAccent,
      controller: traslado,
      obscureText: false,
      style: style,
      onChanged: (val) {
        setState(() {
          formattedDatetras = val;
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
        final DateTime pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.parse('2023-01-01'),
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

  seleccionarVia() {
    return Container(
      child: FutureBuilder<List<Via>>(
        future: _providerGRElectronica.getVia(),
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
                    await _providerGRElectronica.getTipoViaCarga(newVal.idVia);

                    setState(() {
                      depatalits = newVal;
                      _guiaRemAux.idVia = newVal.idVia.toString();
                      idVia_ = newVal.idVia.toString();
                      selectV = newVal.nombreVia;
                      // valorheig = 50.0;
                    });
                  },
                  value: depatalits,
                  hint: Text("   $selectV"),
                ));
          }
        },
      ),
    );
  }

  seleccionarTV() {
    return Container(
      child: FutureBuilder<List<TipoViaCarga>>(
        future: _providerGRElectronica.getTipoViaCarga(_guiaRemAux.idVia),
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
                      selectTv = newVal.tipo_via_carga;
                      _guiaRemAux.idTipoVia =
                          newVal.id_tipo_via_carga.toString();
                      idTipoCarga_ = newVal.id_tipo_via_carga.toString();
                    });
                  },
                  value: depatalits,
                  hint: Text("   $selectTv"),
                ));
          }
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
        suggestionsCallback: ProviderGRElectronica.getDSuggestionsconductor,
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
            controlador.text = suggestion.empleado;
            _guiaRemAux.idConductor = suggestion.idEmpleado.toString();
            textAuxiliar.replaceAll('', suggestion.empleado);
            idConductor_ = suggestion.idEmpleado.toString();
          });
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('${suggestion.idEmpleado}')));
        },
      ),
    );
  }

  imputAgente(textAuxiliar, controlador) {
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
              suffixText: textAuxiliar,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              hoverColor: Color(0xFF3949AB),
              focusColor: Color(0xFF3949AB)),
        ),
        suggestionsCallback: ProviderGRElectronica.getUserSuggestions,
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
            idAgente_ = suggestion.idAgente.toString();

            textAuxiliar = suggestion.cuenta;
            agente.text = textAuxiliar;
            _guiaRemAux.idAgente = suggestion.idAgente.toString();
            textAuxiliar.replaceAll('', suggestion.cuenta);
            idAgente_ = suggestion.idAgente.toString();
          });
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('${suggestion.idAgente}')));
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
        suggestionsCallback: ProviderGRElectronica.getEndidadSuggestions,
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
            //   _guiaRemAux.remitente = suggestion.razon_social;
            controlador.text = suggestion.razon_social;
            _guiaRemAux.idDestinatario = suggestion.id_entidad.toString();
            textAuxiliar.replaceAll('', suggestion.razon_social);
            idDestinatario_ = suggestion.id_entidad.toString();
          });
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('${suggestion.id_entidad}')));
        },
      ),
    );
  }

  imputDllegada(texto) {
    return Container(
      padding: EdgeInsets.all(0),
      child: TypeAheadField<Direccion>(
        hideSuggestionsOnKeyboardHide: false,
        debounceDuration: Duration(milliseconds: 500),
        textFieldConfiguration: TextFieldConfiguration(
          controller: direccionLlegado,
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
            direccionLlegado.text = suggestion.direccion;
            _guiaRemAux.idDireccionLlegada = suggestion.id_direccion.toString();
            idDireccionLlegada_ = suggestion.id_direccion.toString();
          });
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('${user.direccion}')));
        },
      ),
    );
  }

  imputCliente(textAuxiliar, controlador) {
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
        suggestionsCallback: ProviderGRElectronica.getEndidadSuggestions,
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
            controlador.text = suggestion.razon_social;
            _guiaRemAux.idCliente = suggestion.id_entidad.toString();
            textAuxiliar.replaceAll('', suggestion.razon_social);
            idCliente_ = suggestion.id_entidad.toString();
          });
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('${suggestion.id_entidad}')));
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
        suggestionsCallback: ProviderGRElectronica.getEndidadSuggestions,
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
            controlador.text = suggestion.razon_social;
            _guiaRemAux.idRemitente = suggestion.id_entidad.toString();
            textAuxiliar.replaceAll('', suggestion.razon_social);
            idRemitente_ = suggestion.id_entidad.toString();
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
            direccionPartida.text = suggestion.direccion;
            _guiaRemAux.idDireccionPartida = suggestion.id_direccion.toString();
            idDireccionPartida_ = suggestion.id_direccion.toString();
          });
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('${user.direccion}')));
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

  serienumero() {
    return Flexible(
        child: new Row(
      children: [
        Flexible(
          child: new TextField(
            enabled: false,
            cursorColor: Colors.blueAccent,
            obscureText: false,
            keyboardType: TextInputType.text,
            style: style,
            onChanged: (x) {
              setState(() {
                print(x);
                _guiaRemAux.serie = x;
              });
            },
            decoration: InputDecoration(
                fillColor: Colors.blueAccent,
                labelText: 'GR Serie',
                hintText: 'GR Serie',
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
            obscureText: false,
            style: style,
            onChanged: (x) {
              setState(() {
                print(x);
                _guiaRemAux.numeroGuia = x;
              });
            },
            decoration: InputDecoration(
                labelText: 'GR Numero',
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

  viatipo() {
    return Flexible(
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
    ));
  }

  guiaremfacttranspo() {
    return Flexible(
        child: new Row(
      children: [
        Flexible(
          child: new TextField(
            cursorColor: Colors.blueAccent,
            obscureText: false,
            keyboardType: TextInputType.number,
            style: style,
            onChanged: (x) {
              setState(() {
                _guiaRemAux.guiaRemisionTransportista = x;
              });
            },
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
            keyboardType: TextInputType.number,
            obscureText: false,
            style: style,
            onChanged: (x) {
              setState(() {
                _guiaRemAux.facturaTransportista = x;
              });
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

  importetrans() {
    return TextField(
      cursorColor: Colors.blueAccent,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      obscureText: false,
      style: style,
      onChanged: (x) {
        setState(() {
          _guiaRemAux.importeTransportista = x;
        });
      },
      decoration: InputDecoration(
          labelText: 'Importe',
          fillColor: Colors.blueAccent,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Importe',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
  }

  comentariotrans() {
    return TextField(
      cursorColor: Colors.blueAccent,
      keyboardType: TextInputType.text,
      obscureText: false,
      style: style,
      onChanged: (x) {
        setState(() {
          _guiaRemAux.comentarioTransportista = x;
        });
      },
      decoration: InputDecoration(
          labelText: 'Comentario',
          fillColor: Colors.blueAccent,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Comentario',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
  }

  fechaftras() {
    return Flexible(
        child: new Row(
      children: [
        Flexible(
          child: fecha('Fecha'),
        ),
        SizedBox(width: 10.0),
        Flexible(
          child: fechaTraslado('Fecha Traslado'),
        ),
      ],
    ));
  }

  boton_AnadirGRC() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.blue[900],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetalleGuiaRmClPage()),
          );
        },
        child: Text("Detalle GRC",
            textAlign: TextAlign.center,
            style: style.copyWith(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  appbar() {
    return AppBar(
      title: Text('Guia REM Auxiliar'),
      backgroundColor: Colors.blue[900],
      actions: [
        // IconButton(
        //   icon: Icon(Icons.document_scanner),
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => DetalleGuiaRmClPage()),
        //     );
        //   },
        // ),
      ],
    );
  }
}
