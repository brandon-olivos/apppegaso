import 'package:Pegaso/src/data/models/Ubigeos.dart';
import 'package:Pegaso/src/data/models/entidades.dart';
import 'package:Pegaso/src/data/models/listaDirecciones.dart';
import 'package:Pegaso/src/data/provider/ProviderAsignacion.dart';
import 'package:Pegaso/src/data/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditDireccionesPage extends StatefulWidget {
  ListaDirecciones band;
  EditDireccionesPage(this.band);
  @override
  State<EditDireccionesPage> createState() => _EditDireccionesPageState();
}

class _EditDireccionesPageState extends State<EditDireccionesPage> {
  final _provider = new Provider();
  //ListaDirecciones _listaDirecciones = ListaDirecciones();
  TextEditingController cliente = TextEditingController();
  TextEditingController direccion = TextEditingController();
  TextEditingController urbanizacion = TextEditingController();
  TextEditingController referencia = TextEditingController();

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  TextEditingController ubigeos = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.band.idDireccion);
    llenarData();
  }

  llenarData() async {
    print(widget.band.idEntidad);
    direccion.text = widget.band.direccion;
    urbanizacion.text = widget.band.urbanizacion;
    cliente.text = widget.band.entidad;
    referencia.text = widget.band.referencia;
    var ubigeo = await _provider.traerUbigeos(widget.band.idUbigeo);
    ubigeos.text = ubigeo.nombreDistrito;
  }

  @override
  Widget build(BuildContext context) {
    Future<Null> refreshList() async {
      await Future.delayed(Duration(seconds: 5));
      _provider.getListaDirecciones('');
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("EDIT DIRECCIONES"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.indigo[900],
        ),
        body: Center(
          child: Container(
            color: Colors.indigo[50],
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    imputCliente('Cliente', cliente),
                    SizedBox(
                      height: 10.0,
                    ),
                    imputUbigeos('Ubigeos', ubigeos),
                    SizedBox(
                      height: 10.0,
                    ),
                    imputvalor(
                        hinttext: "Direccion",
                        label: "Direccion",
                        controller: direccion,
                        keyTipo: TextInputType.text),
                    SizedBox(
                      height: 10.0,
                    ),
                    imputvalor(
                        hinttext: "Urbanizacion",
                        label: "Urbanizacion",
                        controller: urbanizacion,
                        keyTipo: TextInputType.text),
                    SizedBox(
                      height: 10.0,
                    ),
                    imputvalor(
                        hinttext: "Referencia",
                        label: "Referencia",
                        controller: referencia,
                        keyTipo: TextInputType.text),
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
          widget.band.direccion = direccion.text;
          widget.band.urbanizacion = urbanizacion.text;
          widget.band.referencia = referencia.text;
          var ar = await _provider.editarDirecciones(widget.band);
          if (ar == 200) {
            Fluttertoast.showToast(
              msg: 'Registro Correcto',
              gravity: ToastGravity.BOTTOM,
            );
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
            widget.band.idEntidad = suggestion.id_entidad.toString();
            textAuxiliar.replaceAll('', suggestion.razon_social);
          });
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('${suggestion.id_entidad}')));
        },
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
            widget.band.idUbigeo = suggestion.idUbigeo.toString();
            textAuxiliar.replaceAll('', suggestion.nombreProvincia);
          });
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('${suggestion.idUbigeo}')));
        },
      ),
    );
  }

  imputvalor({label, hinttext, controller, keyTipo}) {
    return TextField(
      inputFormatters: [
        UpperCaseTextFormatter(),
      ],
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
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
