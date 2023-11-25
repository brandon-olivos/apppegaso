import 'package:Pegaso/src/data/models/MControlKilometraje.dart';
import 'package:Pegaso/src/data/models/vehiculo.dart';
import 'package:Pegaso/src/data/provider/ProviderControlKilometraje.dart';
import 'package:Pegaso/src/data/provider/ProviderGuiasAuxiliar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';

class AgregarControlKilometrajePage extends StatefulWidget {
  @override
  State<AgregarControlKilometrajePage> createState() =>
      _AgregarControlKilometrajePageState();
}

class _AgregarControlKilometrajePageState
    extends State<AgregarControlKilometrajePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController fechainicio = TextEditingController();
  TextEditingController horaSalidacontroller = TextEditingController();
  TextEditingController horaLlegadacontroller = TextEditingController();
  TextEditingController vehiculo = TextEditingController();
  TextEditingController kilometrajeSalida = TextEditingController();
  TextEditingController kilometrajeLlegada = TextEditingController();
  TextEditingController kilometroRecorrido = TextEditingController();
  MControlKilometraje controlKilometraje = new MControlKilometraje();
  final _providerck = ProviderControlKilometraje();

  var idVehiculo;
  var _currentSelectDate = DateTime.now();
  var _curremtime = TimeOfDay.now();
  var selectTime;
  var selectLlegada;
  var heightEspacio = 10.0;

  void callDaterPiker() async {
    var selectDate = await getDatePikerwidget();
    setState(() {
      _currentSelectDate = selectDate;
    });
  }

  Future<DateTime> getDatePikerwidget() {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime(2050),
        builder: (context, child) {
          return Theme(data: ThemeData.dark(), child: child);
        });
  }

  Future<TimeOfDay> getTimePikerwidget() {
    return showTimePicker(
        context: context,
        initialTime: _curremtime,
        builder: (context, child) {
          return Theme(data: ThemeData.dark(), child: child);
        });
  }

  DateTime nowfec = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.indigo[900],
          title: Text(
            'Registro CK',
            style: TextStyle(color: Colors.white),
          ),
          elevation: 1,
        ),
        body: Center(
            child: Container(
                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: ListView(children: [
                      hora(horaSalidacontroller, selectTime, 'Hora Salida',
                          controlKilometraje.horaSalida),
                      SizedBox(height: heightEspacio),
                      imputVehiculo(
                          'Vehiculo', vehiculo, controlKilometraje.idVehiculo),
                      SizedBox(height: heightEspacio),
                      hora(horaLlegadacontroller, selectLlegada, 'Hora Llegada',
                          controlKilometraje.horaSalida),
                      SizedBox(height: heightEspacio),
                      kilometraje(
                          'Kilometraje Salida',
                          TextInputType.number,
                          kilometrajeSalida,
                          controlKilometraje.kilometrajeSalida,
                          true),
                      SizedBox(height: heightEspacio),
                      kilometraje(
                          'Kilometraje llegada',
                          TextInputType.number,
                          kilometrajeLlegada,
                          controlKilometraje.kilometrajeLlegada,
                          true),
                      SizedBox(height: heightEspacio),
                      kilometraje(
                          'Kilometro Recorrido',
                          TextInputType.number,
                          kilometroRecorrido,
                          controlKilometraje.kilometroRecorrido,
                          false),
                      SizedBox(height: heightEspacio),
                      guardarCK()
                    ])))));
  }

  fecha(fechatext, fecha_inicio) {
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
        //  print(formattedDate); // 2016-01-25
        nowfec = await showDatePicker(
            context: context,
            initialDate: nowfec,
            firstDate: DateTime(1900),
            lastDate: DateTime(2100));

        setState(() {});
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
        setState(() {
          _curremtime = selectTime;
          DateTime date =
              DateFormat.jm().parse("${_curremtime.format(context)}");
          horaSalida.text = "${DateFormat("HH:mm").format(date)}";
        });
      },
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
            idVehiculo = suggestion.idVehiculo;
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

  kilometraje(label, keytype, controller, change, enable) {
    return TextField(
      enabled: enable,
      cursorColor: Colors.blueAccent,
      obscureText: false,
      controller: controller,
      keyboardType: keytype,
      style: style,
      onChanged: (value) {
        print(value);
        setState(() {
          change = value;
          var ks = double.parse(kilometrajeLlegada.text) -
              double.parse(kilometrajeSalida.text);
          kilometroRecorrido.text = ks.toString();
        });
      },
      decoration: InputDecoration(
          fillColor: Colors.blueAccent,
          labelText: label,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: label,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
  }

  guardarCK() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        elevation: 10.0,
        borderRadius: BorderRadius.circular(52.0),
        color: Colors.blue[900],
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(15.0, 15.0, 20.0, 15.0),
          onPressed: () async {
            controlKilometraje.horaSalida = horaSalidacontroller.text;
            controlKilometraje.idVehiculo = idVehiculo;
            controlKilometraje.horaLlegada = horaLlegadacontroller.text;
            controlKilometraje.kilometrajeSalida = kilometrajeSalida.text;
            controlKilometraje.kilometrajeLlegada = kilometrajeLlegada.text;
            controlKilometraje.kilometroRecorrido = kilometroRecorrido.text;

            var s = await _providerck
                .registrarControlKilometraje(controlKilometraje);

            setState(() {
              if (s == '200') {
                Navigator.pop(context, 'OK');
              }
            });
          },
          child: Text("Guardar",
              textAlign: TextAlign.center,
              style: style.copyWith(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
