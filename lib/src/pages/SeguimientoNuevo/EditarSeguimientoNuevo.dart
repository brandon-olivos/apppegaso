import 'package:Pegaso/src/data/models/ListaSeguimientoNuevo.dart';
import 'package:Pegaso/src/data/provider/providerLista.dart';
import 'package:Pegaso/src/data/provider/provider.dart';
import 'package:Pegaso/src/pages/SeguimientoNuevo/tablaGCseguimiento.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:Pegaso/src/data/models/estados.dart';

class EditarSeguimientoNuevoPage extends StatefulWidget {
  final String idGuiaRem;

  EditarSeguimientoNuevoPage({this.idGuiaRem = ''});

  @override
  State<EditarSeguimientoNuevoPage> createState() =>
      _EditarSeguimientoNuevoPageState();
}

class _EditarSeguimientoNuevoPageState
    extends State<EditarSeguimientoNuevoPage> {
  final PageController _pageController = PageController();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15);

  TextEditingController id_guia_remision = TextEditingController();
  TextEditingController numero_guia = TextEditingController();
  TextEditingController fecha = TextEditingController();
  TextEditingController fecha_traslado = TextEditingController();
  TextEditingController via = TextEditingController();
  TextEditingController remitente = TextEditingController();
  TextEditingController direccion_partida = TextEditingController();
  TextEditingController destinatario = TextEditingController();
  TextEditingController direccion_llegada = TextEditingController();
  TextEditingController id_estado = TextEditingController();
  TextEditingController comentario = TextEditingController();

  DateTime currentDate = DateTime.now();
  final _providerLista = new ProviderLista();
  // ignore: unused_field
  final _provider = new Provider();
  var dato;
  var tamanioboton = 50.0;

  ListaSeguimientoNuevos _guiaRemAux = ListaSeguimientoNuevos();

  //lama a la funcion paraa mostrar los traer los daTOS
  Future refreshList() async {
    print(widget.idGuiaRem);
    await Future.delayed(Duration(seconds: 0));
    var a = await _providerLista.getseguimiento(widget.idGuiaRem);
    setState(() {
      _guiaRemAux = a;
      print(_guiaRemAux.id_guia_remision);
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
    //id_guia_remision.text = _guiaRemAux.id_guia_remision;
    numero_guia.text = _guiaRemAux.numero_guia;
    fecha.text = _guiaRemAux.fecha;
    fecha_traslado.text = _guiaRemAux.fecha_traslado;
    via.text = _guiaRemAux.via;
    remitente.text = _guiaRemAux.remitente;
    direccion_partida.text = _guiaRemAux.direccion_partida;
    destinatario.text = _guiaRemAux.destinatario;
    direccion_llegada.text = _guiaRemAux.direccion_llegada;
    id_estado.text = _guiaRemAux.nombre_estado;
    comentario.text = _guiaRemAux.comentario;
    //SELECT = NOMBRE_PERFIL
    //nombrePerfil.text = _guiaRemAux.nombrePerfil;
    //nombreArea.text = _guiaRemAux.nombreArea;
    //

    print(_guiaRemAux.id_guia_remision);

    String formattedDatetras = formatter.format(nowtras);

//CUERPO DE PANTALLA

    return Scaffold(
      appBar: AppBar(
        title: Text('GRP - ${_guiaRemAux.numero_guia}'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.indigo[900],
        actions: [
          IconButton(
            icon: Icon(Icons.document_scanner),
          ),
        ],
      ),
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

                //FECHAS MITAD 5.0+
                children: <Widget>[
                  ////////////////////////
                  //SizedBox(height: 10.0),
                  //imputControlador_disabled('N° Guia', numero_guia),
                  SizedBox(height: 10.0),
                  fechas(),
                  SizedBox(height: 10.0),
                  imputControlador_disabled('Via', via),
                  SizedBox(height: 10.0),
                  imputControlador_disabled('Remitente', remitente),
                  SizedBox(height: 10.0),
                  imputControlador_disabled(
                      'Direccion Partida', direccion_partida),
                  SizedBox(height: 10.0),
                  imputControlador_disabled('Destinatario', destinatario),
                  SizedBox(height: 10.0),
                  imputControlador_disabled(
                      'Direccion Llegada', direccion_llegada),
                  SizedBox(height: 10.0),
                  inputEstado('Estado', id_estado),
                  SizedBox(height: 10.0),
                  imputControlador_enabled('Comentario', comentario),
                  SizedBox(height: 10.0),

                  TablaGCSeguimiento(
                      idGuiaRemision: int.parse(widget.idGuiaRem)),

                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Material(
                      elevation: 4.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.blue[900],
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () {
                          setState(() {
                            save();
                          });
                        },
                        child: Text("Guardar",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
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

  save() async {
    await _providerLista.editarGRPegasoSeguimiento(
      id_guia_remision: _guiaRemAux.id_guia_remision,
      id_estado: _guiaRemAux.id_estado,
      comentario: comentario.text,
    );
    Navigator.of(context).pop();
    setState(() {});
  }

  fechas() {
    return Flexible(
        child: new Row(
      children: [
        Flexible(
          child: imputControlador_disabled('Fecha', fecha),
        ),
        SizedBox(width: 10.0),
        Flexible(
          child: imputControlador_disabled('Fecha Traslado', fecha_traslado),
        )
      ],
    ));
  }

  imputControlador_disabled(text, controlador) {
    return TextField(
      enabled: false,
      cursorColor: Colors.blueAccent,
      keyboardType: TextInputType.text,
      obscureText: false,
      style: style,
      onChanged: (x) {
        _guiaRemAux.usuario = x;
      },
      controller: controlador,
      decoration: InputDecoration(
          labelText: text,
          fillColor: Colors.blueAccent,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: text.toString(),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
  }

  imputControlador_enabled(text, controlador) {
    return TextField(
      cursorColor: Colors.blueAccent,
      keyboardType: TextInputType.text,
      obscureText: false,
      style: style,
      onChanged: (x) {
        _guiaRemAux.usuario = x;
      },
      controller: controlador,
      decoration: InputDecoration(
          labelText: text,
          fillColor: Colors.blueAccent,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: text.toString(),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
  }

  ///SELECT
  inputEstado(textAuxiliar, controlador) {
    return Container(
      padding: EdgeInsets.all(0),
      child: TypeAheadField<Estados>(
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
              'No Perfil',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
        onSuggestionSelected: (Estados suggestion) {
          setState(() {
            _guiaRemAux.nombre_estado = suggestion.nombre_estado;
            _guiaRemAux.id_estado = suggestion.id_estado.toString();
            textAuxiliar.replaceAll('', suggestion.nombre_estado);
          });
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('${suggestion.id_estado}')));
        },
      ),
    );
  }
}
