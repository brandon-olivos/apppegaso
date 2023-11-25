import 'dart:convert';
import 'dart:io';

import 'package:Pegaso/src/Pages/Asignaciones/detalleguia/Detalleguiaed.dart';
import 'package:Pegaso/src/data/db/token.dart';
import 'package:Pegaso/src/data/models/TipoCarga.dart';
import 'package:Pegaso/src/data/models/TipoViaCarga.dart';
import 'package:Pegaso/src/data/models/Via.dart';
import 'package:Pegaso/src/data/models/agente.dart';
import 'package:Pegaso/src/data/models/direccion.dart';
import 'package:Pegaso/src/data/models/entidades.dart';
import 'package:Pegaso/src/data/models/guia_rem_cliente_m.dart';
import 'package:Pegaso/src/data/provider/ProviderAsignacion.dart';
import 'package:Pegaso/src/data/provider/provider.dart';
import 'package:Pegaso/src/pages/Asignaciones/detalle_grc.dart';
import 'package:Pegaso/src/pages/Asignaciones/detalleguia/tablaGcliente.dart';

import 'package:Pegaso/src/util/app-config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:vibration/vibration.dart';

// ignore: must_be_immutable
class AtendenderAsignacion extends StatefulWidget {
  String solicitud = "";
  String id = "";
  String fecha = '';
  int refresh = 0;
  String destinatario = '';
  String idDestinatario = '';
  String direccionLlegada = '';
  String idDireccionDestino = '';

//SecondPage(this.refresh); //constructor
  AtendenderAsignacion(
      {this.solicitud = '',
      this.id = '',
      this.fecha = '',
      this.refresh = 0,
      this.destinatario = '',
      this.idDestinatario = '',
      this.direccionLlegada = '',
      this.idDireccionDestino = ''});

  static String route = '/';

  @override
  _AtendenderAsignacionState createState() => _AtendenderAsignacionState();
}

class _AtendenderAsignacionState extends State<AtendenderAsignacion> {
  var _image, _imageby;
  String image64;
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<Direccion>> key = new GlobalKey();

  static List<Direccion> users = [];
  bool loading = true;
  var idDestinatario = 0;
  var idAgente = 0;
  var dato;

  DateTime nowfec = new DateTime.now();
  DateTime nowtras = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');

  mostrarDatos() async {
    //  await DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getUltimoToken();
    dato = abc.toString();
    return dato;
  }

  Map<String, String> get headers {
    mostrarDatos();
    //tokenUsuario.toMap(DatabasePr.db.getUltimoToken());

    return {
      // TODO: TOKEN DEL SQLITE

      // ignore: unnecessary_brace_in_string_interps
      "Authorization": "Bearer $dato",
      'Content-Type': 'application/json'
    };
  }

  void getDireccionllegada(idDestinatario) async {
    await mostrarDatos();
    print(idDestinatario);
    try {
      final response = await http.post(
          Uri.parse(AppConfig.urlBackendMovil +
              '/atenderasignaciones/rest/direccion'),
          body: '{ "entidad":$idDestinatario}',
          headers: headers);
      if (response.statusCode == 200) {
        users = loadUsers(response.body);
        setState(() {
          loading = false;
        });
      } else {}
    } catch (e) {}
  }

  static List<Direccion> loadUsers(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Direccion>((json) => Direccion.fromJson(json)).toList();
  }

  final _providerAsignacion = new ProviderAsignacion();
  final _provider = new Provider();

  //final providerRegistro = new ProviderRegistro();
  var selectV = "SELECIONAR VIA";
  var selectTv = "SELECIONAR TVIA";
  var idVia = 0;
  var idTipoVia = 0;
  var textAuxiliar = 'Agente';
  var textDestinatario = 'Destinatario';

  var textDLlegada = 'Direccion LLegada';
  var idDllega = 0;
  DateTime currentDate = DateTime.now();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController email = new TextEditingController();
  TextEditingController fechainicio = TextEditingController();
  TextEditingController traslado = TextEditingController();
  TextEditingController via = TextEditingController();
  TextEditingController agente = TextEditingController();
  TextEditingController destinatario = TextEditingController();
  TextEditingController detalleGuiaSerie = TextEditingController();
  TextEditingController detalleGuiaNumero = TextEditingController();
  TextEditingController detalleCantidad = TextEditingController();
  TextEditingController detallePeso = TextEditingController();
  TextEditingController detalleLargo = TextEditingController();
  TextEditingController detalleAncho = TextEditingController();
  TextEditingController detalleAlto = TextEditingController();
  TextEditingController detallePesoVol = TextEditingController();
  TextEditingController dircllegada = TextEditingController();

  var serie = 'serie';
  var numeroguia = 'nm';
  var valorheig = 0.0;

  Future<List<Direccion>> getDSuggestions(String query) async {
    final url = Uri.parse(
      AppConfig.urlBackendMovil + '/atenderasignaciones/rest/direccion',
    );

    final response = await http.post(url,
        body: '{ "entidad":$idDestinatario}', headers: headers);

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

  bool canVibrate = false;

  @override
  // ignore: must_call_super
  void initState() {
    destinatario.text = widget.destinatario;
    dircllegada.text = widget.direccionLlegada;
  }

  List<GuiaRemClienteM> list = [];

  bool isLoading = false;

  List<String> autoCompleteData = [];

  TextEditingController controller = new TextEditingController();

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 2.0, color: Colors.grey[400]),
      borderRadius: BorderRadius.all(
          Radius.circular(10.0) //                 <--- border radius here
          ),
    );
  }

  Widget row(Direccion user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          user.direccion,
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          user.direccion,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = formatter.format(nowfec);
    String formattedDatetras = formatter.format(nowtras);

    fecha(fechatext, fecha_inicio) {
      fechainicio.text = fecha_inicio;
      return TextField(
        cursorColor: Colors.blueAccent,
        controller: fechainicio,
        obscureText: false,
        style: style,
        enabled: false,
        decoration: InputDecoration(
            labelText: fechatext,
            fillColor: Colors.blueAccent,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: fechatext,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
        onTap: () async {
          print(formattedDate); // 2016-01-25
          nowfec = await showDatePicker(
              context: context,
              initialDate: nowfec,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100));

          setState(() {
            fechainicio.text.replaceAll('', formatter.format(nowfec));
            //  fecha_inicio.text = nowfec.toIso8601String();
          });
        },
      );
    }

    fechaTraslado(fechatext, varFecha) {
      traslado.text = varFecha;
      return TextField(
        cursorColor: Colors.blueAccent,
        controller: traslado,
        obscureText: false,
        style: style,
        enabled: false,
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

          nowtras = await showDatePicker(
              context: context,
              initialDate: nowtras,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100));

          setState(() {
            traslado.text.replaceAll('', formatter.format(nowtras));
            varFecha = formatter.format(nowtras);
          });
        },
      );
    }

    final seleccionarVia = new Container(
      child: FutureBuilder<List<Via>>(
        future: _provider.getVia(),
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
                      idVia = newVal.idVia;

                      selectV = newVal.nombreVia;

                      valorheig = 50.0;
                    });
                  },
                  value: depatalits,
                  hint: Text("   $selectV"),
                ));
          }
        },
      ),
    );
    seleccionarTV() {
      return Container(
        child: FutureBuilder<List<TipoViaCarga>>(
          future: _provider.getTipoViaCarga(idVia),
          builder: (BuildContext context,
              AsyncSnapshot<List<TipoViaCarga>> snapshot) {
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
                        idTipoVia = newVal.id_tipo_via_carga;
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

    imputFields(texto, controlador) {
      return Container(
        padding: EdgeInsets.all(0),
        child: TypeAheadField<Agente>(
          hideSuggestionsOnKeyboardHide: true,
          debounceDuration: Duration(milliseconds: 500),
          textFieldConfiguration: TextFieldConfiguration(
            controller: agente,
            decoration: InputDecoration(
                labelText: textAuxiliar,
                fillColor: Color(0xFF3949AB),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: textAuxiliar,
                suffixText: '',
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
              textAuxiliar = suggestion.cuenta;

              agente.text = textAuxiliar;
              idAgente = suggestion.idAgente;
              textAuxiliar.replaceAll('', suggestion.cuenta);
            });
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text('${suggestion.idAgente}')));
          },
        ),
      );
    }

    imputEntidades(texto, controlador) {
      return Container(
        padding: EdgeInsets.all(0),
        child: TypeAheadField<Entidad>(
          hideSuggestionsOnKeyboardHide: false,
          debounceDuration: Duration(milliseconds: 500),
          textFieldConfiguration: TextFieldConfiguration(
            controller: destinatario,
            decoration: InputDecoration(
                labelText: textDestinatario,
                fillColor: Color(0xFF3949AB),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: textDestinatario,
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
                'No Entidades',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          onSuggestionSelected: (Entidad suggestion) {
            final user = suggestion;
            setState(() {
              textDestinatario = user.razon_social;
              idDestinatario = suggestion.id_entidad;
              destinatario.text = suggestion.razon_social;
              widget.idDestinatario = user.id_entidad.toString();
              getDireccionllegada(user.id_entidad);
            });
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text('${user.id_entidad}')));
          },
        ),
      );
    }

    imputDLlegada(texto, controlador) {
      return Container(
        padding: EdgeInsets.all(0),
        child: TypeAheadField<Direccion>(
          hideSuggestionsOnKeyboardHide: false,
          debounceDuration: Duration(milliseconds: 500),
          textFieldConfiguration: TextFieldConfiguration(
            controller: controlador,
            decoration: InputDecoration(
              labelText: textDLlegada,
              fillColor: Color(0xFF3949AB),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: textDLlegada,
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
                'No Direccion Llegada',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          onSuggestionSelected: (Direccion suggestion) {
            final user = suggestion;
            setState(() {
              textDLlegada = user.direccion;
              controlador.text = user.direccion;
              idDllega = int.parse(user.id_direccion);
              widget.idDireccionDestino = user.id_direccion.toString();
            });
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text('${user.direccion}')));
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
            print(
                "$idAgente ${widget.idDireccionDestino}  ${widget.idDestinatario} ${idVia} $idTipoVia ");
            if (idAgente != null &&
                widget.idDireccionDestino != null &&
                widget.idDestinatario != null &&
                idVia > 0 &&
                idTipoVia > 0) {
              //mensaje de espera
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
              /////action de guardar y emitir
              var rspt = await _providerAsignacion.registrarGuia(
                  fecha: fechainicio.text,
                  traslado: traslado.text,
                  agente: idAgente,
                  via: idVia,
                  via_tipo: idTipoVia,
                  destinatario: widget.idDestinatario,
                  direccion_llegada: widget.idDireccionDestino,
                  id_atencion_pedido: widget.id,
                  imagen: image64);
              if (rspt == 200) {
                //si grabo
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }
            } else {
              setState(() {
                Vibration.vibrate(duration: 1000);
              });

              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Te faltan datos'),
                  // content: const Text('Desea Eliminar esta Guia?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {},
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

    agregarGuiaCliente() {
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
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
      );
    }

    final cancelar = Material(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Text("cancelar",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ),
    );

    Future cameraImage() async {
      var image = await ImagePicker()
          .pickImage(source: ImageSource.camera, maxWidth: 700);
      setState(() {
        _imageby = image?.path;
        _image = image;
      });
      List<int> bytes = await new File(_imageby).readAsBytesSync();
      image64 = base64Encode(bytes);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.solicitud),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.indigo[900],
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

                  fecha('Fecha', formattedDate),
                  SizedBox(height: 10.0),
                  fechaTraslado('Fecha Traslado', formattedDatetras),
                  SizedBox(height: 10.0),
                  seleccionarVia,
                  // seleccionarVa(_providerAsignacion.getTipoCarga()),
                  SizedBox(height: 10.0),
                  SizedBox(height: valorheig, child: seleccionarTV()),

                  SizedBox(height: 10.0),
                  //impuit(),
                  imputFields('preuwba', agente),
                  SizedBox(height: 10.0),
                  imputEntidades("texto", ''),
                  SizedBox(height: 10.0),
                  imputDLlegada('', dircllegada),
                  //autocompletar(),
                  SizedBox(height: 10.0),
                  agregarGuiaCliente(),
                  SizedBox(height: 10.0),

                  SizedBox(height: 10.0),
                  TablaGiaClienteAsix(
                    title: '',
                  ),
                  //z      hola(),
                  SizedBox(height: 12.0),
                  guardarG(),
                  SizedBox(
                    height: 10.0,
                  ),
                  cancelar,
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
