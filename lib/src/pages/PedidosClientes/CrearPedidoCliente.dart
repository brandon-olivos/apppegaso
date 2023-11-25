import 'package:Pegaso/src/data/models/ListaPedidosClientes.dart';
import 'package:Pegaso/src/data/models/TipoUnidad.dart';
import 'package:Pegaso/src/data/models/direccion.dart';
import 'package:Pegaso/src/data/models/tipoServicio.dart';
import 'package:Pegaso/src/data/provider/ProviderListaPedidosClientes.dart';
import 'package:Pegaso/src/data/provider/Provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:vibration/vibration.dart';

class CrearPedidoCliente extends StatefulWidget {
  String titulo;

  CrearPedidoCliente({this.titulo});
  @override
  State<CrearPedidoCliente> createState() => _CrearPedidoClientePageState();
}

class _CrearPedidoClientePageState extends State<CrearPedidoCliente> {
  final PageController _pageController = PageController();

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController fecharecojo = TextEditingController();
  TextEditingController horarecojo = TextEditingController();
  TextEditingController direccion = TextEditingController();
  TextEditingController tiposervicio = TextEditingController();
  TextEditingController tipounidad = TextEditingController();
  TextEditingController iddireccionrecojo = TextEditingController();

  final _providerAsignacion = new ProviderListaPedidosClientes();

  ListaPedidosClientes _pedidoClienteSave = ListaPedidosClientes();

  final _provider = new Provider();
  var selectTv = " Tipo Servicio";

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
  bool canVibrate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Pedido Cliente'),
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

      //appBar: appbar(),
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
                  fechahora(),
                  SizedBox(height: 10.0),
                  imputServicio('Tipo Servicio', tiposervicio),
                  SizedBox(height: 10.0),
                  imputTipoUnidad('Tipo Unidad', tipounidad),
                  SizedBox(height: 10.0),
                  imputDireccion('Direccion Recojo', iddireccionrecojo),
                  SizedBox(height: 10.0),
                  guardarG(),
                  SizedBox(height: 10.0),
                ],
              ),
            ]),
          ),
        ),
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
          ///
          ///
          if (fecharecojo.text == "" || tiposervicio.text == "") {
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
          } else {
            await _providerAsignacion.GuardarPedidoCliente(
                pedidoclientesave: _pedidoClienteSave);
            setState(() {});
            Navigator.of(context).pop();
          }
          ////
          ///
          ///
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

  imputDireccion(textAuxiliar, controlador) {
    return Container(
      padding: EdgeInsets.all(0),
      child: TypeAheadField<DireccionesMod>(
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
        suggestionsCallback: ProviderListaPedidosClientes.getDireccionRecojo,
        itemBuilder: (context, DireccionesMod suggestion) {
          final user = suggestion;

          return ListTile(
            title: Text(user.direccion),
          );
        },
        noItemsFoundBuilder: (context) => Container(
          height: 100,
          child: Center(
            child: Text(
              'No Servicio',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
        onSuggestionSelected: (DireccionesMod suggestion) {
          setState(() {
            controlador.text = suggestion.direccion;
            _pedidoClienteSave.id_direccion_recojo =
                suggestion.id_direccion.toString();
            textAuxiliar.replaceAll('', suggestion.direccion);
          });
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
                SnackBar(content: Text('${suggestion.id_direccion}')));
        },
      ),
    );
  }

  imputTipoUnidad(textAuxiliar, controlador) {
    return Container(
      padding: EdgeInsets.all(0),
      child: TypeAheadField<TipoUnidad>(
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
        suggestionsCallback: ProviderListaPedidosClientes.getTipoUnidad,
        itemBuilder: (context, TipoUnidad suggestion) {
          final user = suggestion;

          return ListTile(
            title: Text(user.descripcion),
          );
        },
        noItemsFoundBuilder: (context) => Container(
          height: 100,
          child: Center(
            child: Text(
              'No Servicio',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
        onSuggestionSelected: (TipoUnidad suggestion) {
          setState(() {
            controlador.text = suggestion.descripcion;
            _pedidoClienteSave.id_tipo_unidad =
                suggestion.id_tipo_unidad.toString();
            textAuxiliar.replaceAll('', suggestion.descripcion);
          });
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
                SnackBar(content: Text('${suggestion.id_tipo_unidad}')));
        },
      ),
    );
  }

  imputServicio(textAuxiliar, controlador) {
    return Container(
      padding: EdgeInsets.all(0),
      child: TypeAheadField<TipoServicio>(
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
        suggestionsCallback: ProviderListaPedidosClientes.getServicio,
        itemBuilder: (context, TipoServicio suggestion) {
          final user = suggestion;

          return ListTile(
            title: Text(user.nombre_producto),
          );
        },
        noItemsFoundBuilder: (context) => Container(
          height: 100,
          child: Center(
            child: Text(
              'No Servicio',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
        onSuggestionSelected: (TipoServicio suggestion) {
          setState(() {
            controlador.text = suggestion.nombre_producto;
            _pedidoClienteSave.tipo_servicio =
                suggestion.id_producto.toString();
            textAuxiliar.replaceAll('', suggestion.nombre_producto);
          });
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
                SnackBar(content: Text('${suggestion.id_producto}')));
        },
      ),
    );
  }

  fechahora() {
    return Flexible(
        child: new Row(
      children: [
        Flexible(
          child: fechaRecojoInput('Fecha Recojo'),
        ),
        SizedBox(width: 10.0),
        Flexible(
          child: horaRecojoInput('Hora Recojo'),
        ),
      ],
    ));
  }

  fechaRecojoInput(fechatext) {
    return TextField(
      cursorColor: Colors.blueAccent,
      controller: fecharecojo,
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
            initialDate: DateTime.now(),
            firstDate: DateTime(2015),
            lastDate: DateTime(2050));
        print(pickedDate);
        if (pickedDate != null && pickedDate != currentDate)
          setState(() {
            currentDate = pickedDate;
            String formattedTime = DateFormat('yyyy-MM-dd').format(pickedDate);
            fecharecojo.text = formattedTime.toString();

            _pedidoClienteSave.fecha = formattedTime;
          });
      },
    );
  }

  horaRecojoInput(fechatext) {
    return TextField(
      cursorColor: Colors.blueAccent,
      controller: horarecojo,
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
        final TimeOfDay pickedDate = await showTimePicker(
            initialTime: TimeOfDay.now(), context: context);
        print(pickedDate);
        if (pickedDate != null)
          setState(() {
            DateTime parsedTime =
                DateFormat.jm().parse(pickedDate.format(context).toString());

            String formattedTime = DateFormat('HH:mm').format(parsedTime);
            horarecojo.text = formattedTime.toString();

            _pedidoClienteSave.hora_recojo = formattedTime;
          });
      },
    );
  }
}
