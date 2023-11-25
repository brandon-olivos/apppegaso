import 'package:Pegaso/src/data/models/Areas.dart';
import 'package:Pegaso/src/data/models/Auxiliar.dart';
import 'package:Pegaso/src/data/models/GuiaRemAux.dart';
import 'package:Pegaso/src/data/models/PedidoCliente.dart';
import 'package:Pegaso/src/data/models/TipoUnidad.dart';
import 'package:Pegaso/src/data/models/conductor.dart';
import 'package:Pegaso/src/data/models/direccion.dart';
import 'package:Pegaso/src/data/models/entidades.dart';
import 'package:Pegaso/src/data/models/fraguil.dart';
import 'package:Pegaso/src/data/models/tipoServicio.dart';
import 'package:Pegaso/src/data/models/vehiculo.dart';
import 'package:Pegaso/src/data/provider/ProviderAsignacion.dart';
import 'package:Pegaso/src/data/provider/ProviderGuiasAuxiliar.dart';
import 'package:Pegaso/src/data/provider/ProviderPedidoClienteOp.dart';
import 'package:Pegaso/src/data/provider/TraerToken.dart';
import 'package:Pegaso/src/data/provider/provider.dart';
import 'package:Pegaso/src/util/app-config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class CrearOperacionesPage extends StatefulWidget {
  @override
  State<CrearOperacionesPage> createState() => _CrearOperacionesPageState();
}

class _CrearOperacionesPageState extends State<CrearOperacionesPage> {
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
  TextEditingController horaLlegadacontroller = TextEditingController();
  TextEditingController contacto = TextEditingController();
  TextEditingController referencia = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController cantidadPersonas = TextEditingController();
  TextEditingController tipounidad = TextEditingController();
  TextEditingController stoka = TextEditingController();
  TextEditingController fragil = TextEditingController();
  TextEditingController cantidad = TextEditingController();
  TextEditingController peso = TextEditingController();
  TextEditingController alto = TextEditingController();
  TextEditingController ancho = TextEditingController();
  TextEditingController largo = TextEditingController();
  TextEditingController estalisto = TextEditingController();
  TextEditingController observacion = TextEditingController();

  // ignore: unused_field
  PedidoCliente _pedidoCliente = PedidoCliente();
  // ignore: unused_field
  final _providerPedidoClienteOp = new ProviderPedidoClienteOp();
  var _curremtime = TimeOfDay.now();
  DateTime nowfec = new DateTime.now();
  DateTime nowtras = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  var selectLlegada;
  var selelectIdTipoServicio = 0;
  var selelectTipoServicio = 'Seleccionar TipoServicio';
  var selelectAreas = 'Seleccionar Areas';
  var selelectIdAreas = 0;
  var selelectTipoUnidad = 'Seleccionar TipoUnidad';
  var selelectIdTipoUnidad = 0;
  var selelectIdFragil = 0;
  var selelectfragil = 'Seleccionar Fragil';
  var selelectStoka = 'Seleccionar Stoka';
  var selelectIdStoka = 0;
  var idVehiculo = 0;
  var selelectIdEstalisto = 0;
  var selelectEstalisto = "Seleccionar Esta Listo";

  String auxilitar = "Seleccionar Auxiliar";
  @override
  Widget build(BuildContext context) {
    _providerPedidoClienteOp.getTipoUnidad();
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
                  SizedBox(height: 10.0),
                  fechaftras(),
                  SizedBox(height: 10.0),
                  tipoServicio(),
                  SizedBox(height: 10.0),
                  imputCliente('Cliente', cliente),
                  SizedBox(height: 10.0),
                  imputRemitente('Remitente', remitente),
                  SizedBox(height: 10.0),
                  imputDpartida('Direccion Partida'),
                  SizedBox(height: 10.0),
                  imputvalor(
                      hinttext: "contacto",
                      label: "contacto",
                      controller: contacto,
                      keyTipo: TextInputType.text),
                  SizedBox(height: 10.0),
                  area(),
                  SizedBox(height: 10.0),
                  imputvalor(
                      hinttext: "referencia",
                      label: "referencia",
                      controller: referencia,
                      keyTipo: TextInputType.text),
                  SizedBox(height: 10.0),
                  imputvalor(
                      hinttext: "telefono",
                      label: "telefono",
                      controller: telefono,
                      keyTipo: TextInputType.number),
                  SizedBox(height: 10.0),
                  imputvalor(
                      hinttext: "Cantidad Personas",
                      label: "Cantidad Personas",
                      controller: cantidadPersonas,
                      keyTipo: TextInputType.number),
                  SizedBox(height: 10.0),
                  tipoUnidad(),
                  SizedBox(height: 10.0),
                  tipoStoka(),
                  SizedBox(height: 10.0),
                  tipoFragil(),
                  SizedBox(height: 10.0),
                  imputvalor(
                    hinttext: "cantidad",
                    label: "cantidad",
                    controller: cantidad,
                    keyTipo: TextInputType.number,
                  ),
                  SizedBox(height: 10.0),
                  imputvalor(
                    hinttext: "peso(opcional)",
                    label: "peso(opcional)",
                    controller: peso,
                    keyTipo: TextInputType.number,
                  ),
                  SizedBox(height: 10.0),
                  imputvalor(
                      hinttext: "alto(opcional)",
                      label: "alto(opcional)",
                      controller: alto,
                      keyTipo: TextInputType.number),
                  SizedBox(height: 10.0),
                  imputvalor(
                      hinttext: "ancho(opcional)",
                      label: "ancho(opcional)",
                      controller: ancho,
                      keyTipo: TextInputType.number),
                  SizedBox(height: 10.0),
                  imputvalor(
                      hinttext: "largo(opcional)",
                      label: "largo(opcional)",
                      controller: largo,
                      keyTipo: TextInputType.number),
                  SizedBox(height: 10.0),
                  tipoEstaListo(),
                  SizedBox(height: 10.0),
                  imputvalor(
                      hinttext: "observación",
                      label: "observación",
                      controller: observacion),
                  SizedBox(height: 10.0),
                  imputConductor('Conductor', conductor),
                  SizedBox(height: 10.0),
                  auxiliar(),
                  SizedBox(height: 10.0),
                  imputVehiculo('Vehiculo', vehiculo, ''),
                  SizedBox(height: 10.0),
                  guardarG(),
                  SizedBox(height: 100.0),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  auxiliar() {
    return Flexible(
        child: new Row(
      children: [
        Flexible(
          child: Container(
            child: FutureBuilder<List<Auxiliar>>(
              future: _providerPedidoClienteOp.getAuxilitar(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Auxiliar>> snapshot) {
                TipoServicio depatalits;

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
                          child: DropdownButton<Auxiliar>(
                            //  icon: Icon(Icons.ac_unit_rounded),

                            underline: SizedBox(),
                            isExpanded: true,
                            items: snapshot.data
                                .map((user) => DropdownMenuItem<Auxiliar>(
                                      child: Text(user.empleado),
                                      value: user,
                                    ))
                                .toList(),
                            onChanged: (Auxiliar newVal) async {
                              setState(() {
                                _pedidoCliente.auxiliar =
                                    int.parse(newVal.id_empleado);
                                auxilitar = newVal.empleado;
                              });
                            },

                            hint: Text("   $auxilitar"),
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
            controlador.text = suggestion.empleado;
            _pedidoCliente.idConductor = int.parse(suggestion.idEmpleado);
            textAuxiliar.replaceAll('', suggestion.empleado);
          });
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('${suggestion.idEmpleado}')));
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
          _pedidoCliente.contacto = contacto.text;
          _pedidoCliente.referencia = referencia.text;
          _pedidoCliente.telefono = telefono.text;
          _pedidoCliente.cantidad_personal = int.parse(cantidadPersonas.text);
          _pedidoCliente.cantidad =
              (cantidad.text != '') ? int.parse(cantidad.text) : 0;
          _pedidoCliente.peso =
              (peso.text != '') ? double.parse(peso.text) : 0; //
          _pedidoCliente.alto = (alto.text != '') ? double.parse(alto.text) : 0;
          _pedidoCliente.ancho =
              (ancho.text != '') ? double.parse(ancho.text) : 0;
          _pedidoCliente.largo =
              (largo.text != '') ? double.parse(largo.text) : 0;
          _pedidoCliente.observacion = observacion.text;
          _pedidoCliente.fecha = fechainicio.text;
          _pedidoCliente.hora_recojo = horaLlegadacontroller.text;
          _pedidoCliente.vehiculo = idVehiculo;
          var ar = await _providerPedidoClienteOp.guardar(_pedidoCliente);
          if (ar == 200) {
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

  appbar() {
    return AppBar(
      title: Text('CrearOperacionesPage'),
      backgroundColor: Colors.blue[900],
      actions: [],
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
          child: hora(horaLlegadacontroller, selectLlegada, 'Hora Llegada', ''),
        ),
      ],
    ));
  }

  fecha(fechatext) {
    String fecha_inicio = formatter.format(nowfec);

    //  _guiaRemAux.fecha = fechainicio.text;
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
        nowfec = await showDatePicker(
            context: context,
            initialDate: nowfec,
            firstDate: DateTime(1900),
            lastDate: DateTime(2100));

        setState(() {
          fechainicio.text.replaceAll('', formatter.format(nowfec));
          // _pedidoCliente.fecha.replaceAll('', formatter.format(nowfec));
          // _guiaRemAux.fecha = fechainicio.text;
          //  fecha_inicio.text = nowfec.toIso8601String();
        });
      },
    );
  }

  hora(horaSalida, selectTime, label, change) {
    return TextField(
      cursorColor: Colors.blueAccent,
      controller: horaSalida,
      obscureText: false,
      style: style,
      onChanged: (value) {
        setState(() {
          change = value;
        });
      },
      decoration: InputDecoration(
          labelText: label,
          fillColor: Colors.blueAccent,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: label,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      onTap: () async {
        selectTime = await getTimePikerwidget();
        var hora = _curremtime.hour;
        _curremtime = selectTime;
        print("${_curremtime.format(context)}");
        //DateTime date = DateFormat.jm().parse("${_curremtime.format(context)}");

        horaSalida.text = "${_curremtime.format(context)}";

        setState(() {});
      },
    );
  }

  Future<TimeOfDay> getTimePikerwidget() {
    return showTimePicker(
        context: context,
        initialTime: _curremtime,
        builder: (context, child) {
          return Theme(data: ThemeData.dark(), child: child);
        });
  }

  tipoServicio() {
    return Flexible(
        child: new Row(
      children: [
        Flexible(
          child: Container(
            child: FutureBuilder<List<TipoServicio>>(
              future: _providerPedidoClienteOp.getTipoServicio(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<TipoServicio>> snapshot) {
                TipoServicio depatalits;

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
                          child: DropdownButton<TipoServicio>(
                            //  icon: Icon(Icons.ac_unit_rounded),

                            underline: SizedBox(),
                            isExpanded: true,
                            items: snapshot.data
                                .map((user) => DropdownMenuItem<TipoServicio>(
                                      child: Text(user.cod_producto +
                                          "::" +
                                          user.nombre_producto +
                                          "::" +
                                          user.unidad_medida),
                                      value: user,
                                    ))
                                .toList(),
                            onChanged: (TipoServicio newVal) async {
                              setState(() {
                                selelectIdTipoServicio = newVal.id_producto;
                                selelectTipoServicio = newVal.cod_producto +
                                    "::" +
                                    newVal.nombre_producto +
                                    "::" +
                                    newVal.unidad_medida;
                                _pedidoCliente.tipo_servicio =
                                    newVal.id_producto;
                              });
                            },

                            hint: Text("   $selelectTipoServicio"),
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

  tipoFragil() {
    return Flexible(
        child: new Row(
      children: [
        Flexible(
          child: Container(
            child: FutureBuilder<List<Fragil>>(
              future: _providerPedidoClienteOp.getFragil(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Fragil>> snapshot) {
                Fragil depatalits;

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
                      // refreshList();

                    }
                    return Container(
                        decoration: Provider().myBoxDecoration(),
                        child: DropdownButton<Fragil>(
                          //  icon: Icon(Icons.ac_unit_rounded),

                          underline: SizedBox(),
                          isExpanded: true,
                          items: snapshot.data
                              .map((user) => DropdownMenuItem<Fragil>(
                                    child: Text(user.valor),
                                    value: user,
                                  ))
                              .toList(),
                          onChanged: (Fragil newVal) async {
                            setState(() {
                              depatalits = newVal;

                              selelectIdFragil = newVal.id;
                              selelectfragil = newVal.valor;
                              _pedidoCliente.fragil = newVal.id;
                            });
                          },
                          value: depatalits,
                          hint: Text("   $selelectfragil"),
                        ));
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

  tipoEstaListo() {
    return Flexible(
        child: new Row(
      children: [
        Flexible(
          child: Container(
            child: FutureBuilder<List<Fragil>>(
              future: _providerPedidoClienteOp.getFragil(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Fragil>> snapshot) {
                Fragil depatalits;

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
                      // refreshList();

                    }
                    return Container(
                        decoration: Provider().myBoxDecoration(),
                        child: DropdownButton<Fragil>(
                          //  icon: Icon(Icons.ac_unit_rounded),

                          underline: SizedBox(),
                          isExpanded: true,
                          items: snapshot.data
                              .map((user) => DropdownMenuItem<Fragil>(
                                    child: Text(user.valor),
                                    value: user,
                                  ))
                              .toList(),
                          onChanged: (Fragil newVal) async {
                            setState(() {
                              depatalits = newVal;

                              selelectIdEstalisto = newVal.id;
                              selelectEstalisto = newVal.valor;
                              _pedidoCliente.estado_mercaderia = newVal.id;
                            });
                          },
                          value: depatalits,
                          hint: Text("   $selelectEstalisto"),
                        ));
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

  tipoStoka() {
    return Flexible(
        child: new Row(
      children: [
        Flexible(
          child: Container(
            child: FutureBuilder<List<Fragil>>(
              future: _providerPedidoClienteOp.getEsoka(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Fragil>> snapshot) {
                Fragil depatalits;

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
                      // refreshList();

                    }
                    return Container(
                        decoration: Provider().myBoxDecoration(),
                        child: DropdownButton<Fragil>(
                          //  icon: Icon(Icons.ac_unit_rounded),

                          underline: SizedBox(),
                          isExpanded: true,
                          items: snapshot.data
                              .map((user) => DropdownMenuItem<Fragil>(
                                    child: Text(user.valor),
                                    value: user,
                                  ))
                              .toList(),
                          onChanged: (Fragil newVal) async {
                            setState(() {
                              depatalits = newVal;

                              selelectIdStoka = newVal.id;
                              selelectStoka = newVal.valor;
                              _pedidoCliente.stoka = newVal.id;
                            });
                          },
                          value: depatalits,
                          hint: Text("   $selelectStoka"),
                        ));
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

  tipoUnidad() {
    return Flexible(
        child: new Row(
      children: [
        Flexible(
          child: Container(
            child: FutureBuilder<List<TipoUnidad>>(
              future: _providerPedidoClienteOp.getTipoUnidad(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<TipoUnidad>> snapshot) {
                TipoUnidad depatalits;

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
                      // refreshList();

                    }
                    return Container(
                        decoration: Provider().myBoxDecoration(),
                        child: DropdownButton<TipoUnidad>(
                          //  icon: Icon(Icons.ac_unit_rounded),

                          underline: SizedBox(),
                          isExpanded: true,
                          items: snapshot.data
                              .map((user) => DropdownMenuItem<TipoUnidad>(
                                    child: Text(user.descripcion),
                                    value: user,
                                  ))
                              .toList(),
                          onChanged: (TipoUnidad newVal) async {
                            setState(() {
                              depatalits = newVal;

                              selelectTipoUnidad = newVal.descripcion;
                              selelectIdTipoUnidad = newVal.id_tipo_unidad;
                              _pedidoCliente.id_tipo_unidad =
                                  newVal.id_tipo_unidad;
                              print(_pedidoCliente.id_tipo_unidad);
                              // valorheig = 50.0;
                            });
                          },
                          value: depatalits,
                          hint: Text("   $selelectTipoUnidad"),
                        ));
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
            controlador.text = suggestion.razon_social;
            _pedidoCliente.id_cliente = suggestion.id_entidad;
            textAuxiliar.replaceAll('', suggestion.razon_social);
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
            controlador.text = suggestion.razon_social;
            _pedidoCliente.id_remitente = suggestion.id_entidad;
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
            direccionPartida.text = suggestion.direccion;
            _pedidoCliente.id_direccion_recojo =
                int.parse(suggestion.id_direccion);
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
        body: '{ "entidad":${_pedidoCliente.id_remitente}} ',
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

  imputvalor({label, hinttext, controller, keyTipo}) {
    return TextField(
      cursorColor: Colors.blueAccent,
      keyboardType: keyTipo,
      obscureText: false,
      style: style,
      controller: controller,
      onChanged: (x) {
        setState(() {});
      },
      decoration: InputDecoration(
          labelText: label,
          fillColor: Colors.blueAccent,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: hinttext,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
  }

  imputVehiculo(textAuxiliar, controlador, change) {
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
              'No  ',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
        onSuggestionSelected: (Vehiculo suggestion) {
          setState(() {
            controlador.text = suggestion.descripcion;
            idVehiculo = int.parse(suggestion.idVehiculo);
            change = suggestion.idVehiculo;
            //_guiaRemAux.idVehiculo = suggestion.idVehiculo.toString();
            textAuxiliar.replaceAll('', suggestion.descripcion);
          });
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
                SnackBar(content: Text('${suggestion.descripcion}')));
        },
      ),
    );
  }

  area() {
    return Flexible(
        child: new Row(
      children: [
        Flexible(
          child: Container(
            child: FutureBuilder<List<Areas>>(
              future: _providerPedidoClienteOp.getAreas(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Areas>> snapshot) {
                Areas depatalits;

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
                      // refreshList();
                      return Container(
                          decoration: Provider().myBoxDecoration(),
                          child: DropdownButton<Areas>(
                            //  icon: Icon(Icons.ac_unit_rounded),

                            underline: SizedBox(),
                            isExpanded: true,
                            items: snapshot.data
                                .map((user) => DropdownMenuItem<Areas>(
                                      child: Text(user.nombre_area),
                                      value: user,
                                    ))
                                .toList(),
                            onChanged: (Areas newVal) async {
                              setState(() {
                                depatalits = newVal;
                                selelectAreas = newVal.nombre_area;
                                // selelectIdAreas = newVal.id_area;
                                _pedidoCliente.id_area = newVal.id_area;
                              });
                            },
                            value: depatalits,
                            hint: Text("   $selelectAreas"),
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
}
