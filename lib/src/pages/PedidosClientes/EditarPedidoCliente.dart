import 'package:Pegaso/src/data/models/ListaPedidosClientes.dart';
import 'package:Pegaso/src/data/models/TipoUnidad.dart';
import 'package:Pegaso/src/data/models/direccion.dart';
import 'package:Pegaso/src/data/models/tipoServicio.dart';
import 'package:Pegaso/src/data/provider/ProviderListaPedidosClientes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:Pegaso/src/data/models/estados.dart';

class EditarPedidoClientePage extends StatefulWidget {
  final String idPedidoCliente;

  EditarPedidoClientePage({this.idPedidoCliente = ''});

  @override
  State<EditarPedidoClientePage> createState() =>
      _EditarSeguimientoNuevoPageState();
}

class _EditarSeguimientoNuevoPageState extends State<EditarPedidoClientePage> {
  final PageController _pageController = PageController();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15);

  TextEditingController fecharecojo = TextEditingController();
  TextEditingController horarecojo = TextEditingController();
  TextEditingController tiposervicio = TextEditingController();
  TextEditingController tipounidad = TextEditingController();
  TextEditingController iddireccionrecojo = TextEditingController();

  DateTime currentDate = DateTime.now();
  bool _isReadonly = false;
  final _providerAsignacion = new ProviderListaPedidosClientes();

  ListaPedidosClientes _listaPedidosClientes = ListaPedidosClientes();

  //lama a la funcion paraa mostrar los traer los daTOS
  Future refreshList() async {
    print(widget.idPedidoCliente);
    await Future.delayed(Duration(seconds: 0));
    var a = await _providerAsignacion.getpedidocliente(widget.idPedidoCliente);
    setState(() {
      _listaPedidosClientes = a;
      print(_listaPedidosClientes.id_pedido_cliente);
      //
      if (_listaPedidosClientes.id_estado == 1.toString()) {
        _isReadonly = true;
      }
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

  @override
  Widget build(BuildContext context) {
    fecharecojo.text = _listaPedidosClientes.fecha;
    horarecojo.text = _listaPedidosClientes.hora_recojo;
    tiposervicio.text = _listaPedidosClientes.nombre_producto;
    tipounidad.text = _listaPedidosClientes.descripcion;
    iddireccionrecojo.text = _listaPedidosClientes.direccion;

    print(_listaPedidosClientes.id_pedido_cliente);

//CUERPO DE PANTALLA

    return Scaffold(
      appBar: AppBar(
        title: Text('N°: ${_listaPedidosClientes.nm_solicitud}'),
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
                children: <Widget>[
                  SizedBox(height: 10.0),
                  fechahora(),
                  SizedBox(height: 10.0),
                  imputServicio('Tipo Servicio', tiposervicio),
                  SizedBox(height: 10.0),
                  imputTipoUnidad('Tipo Unidad', tipounidad),
                  SizedBox(height: 10.0),
                  imputDireccion('Direccion Recojo', iddireccionrecojo),
                  SizedBox(height: 15.0),
                  btnActualizar(),
                  SizedBox(height: 10.0),
                  btnEliminar(),
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

  btnEliminar() {
    if (_listaPedidosClientes.id_estado == 1.toString()) {
      return Material(
        elevation: 5.0,
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.red[900],
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
              setState(() {
                __mostrarMsnEliminar(context);
              });
            },
            child: Text("Eliminar",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
      );
    } else {
      return Material();
    }
  }

  btnActualizar() {
    if (_listaPedidosClientes.id_estado == 1.toString()) {
      return Material(
        elevation: 5.0,
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.blue[900],
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
              setState(() {
                actualizar();
              });
            },
            child: Text("Actualizar",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
      );
    } else {
      return Material();
    }
  }

  void __mostrarMsnEliminar(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Eliminar N°" + _listaPedidosClientes.nm_solicitud),
            content: Text("¿Estas seguro(a)?"),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      eliminar();
                      Navigator.of(context).pop();
                    });
                  },
                  child: Text("Si")),
              TextButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: Text("Cancelar")),
            ],
          );
        });
  }

  eliminar() async {
    await _providerAsignacion.eliminarPedidosCliente(
        id_pedido_cliente: _listaPedidosClientes.id_pedido_cliente);
    Navigator.of(context).pop();
    setState(() {});
  }

  actualizar() async {
    await _providerAsignacion.editarPedidosCliente(
        id_pedido_cliente: _listaPedidosClientes.id_pedido_cliente,
        fecha: _listaPedidosClientes.fecha,
        hora_recojo: _listaPedidosClientes.hora_recojo,
        tipo_servicio: _listaPedidosClientes.tipo_servicio,
        id_tipo_unidad: _listaPedidosClientes.id_tipo_unidad,
        id_direccion_recojo: _listaPedidosClientes.id_direccion_recojo);
    Navigator.of(context).pop();
    setState(() {});
  }

  imputServicio(textAuxiliar, controlador) {
    return Container(
      padding: EdgeInsets.all(0),
      child: TypeAheadField<TipoServicio>(
        hideSuggestionsOnKeyboardHide: true,
        debounceDuration: Duration(milliseconds: 500),
        textFieldConfiguration: TextFieldConfiguration(
          enabled: _isReadonly,
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
            _listaPedidosClientes.nombre_producto = suggestion.nombre_producto;
            _listaPedidosClientes.tipo_servicio =
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

  imputDireccion(textAuxiliar, controlador) {
    return Container(
      padding: EdgeInsets.all(0),
      child: TypeAheadField<DireccionesMod>(
        hideSuggestionsOnKeyboardHide: true,
        debounceDuration: Duration(milliseconds: 500),
        textFieldConfiguration: TextFieldConfiguration(
          controller: controlador,
          enabled: _isReadonly,
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
            _listaPedidosClientes.direccion = suggestion.direccion;
            _listaPedidosClientes.id_direccion_recojo =
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
          enabled: _isReadonly,
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
            _listaPedidosClientes.descripcion = suggestion.descripcion;
            _listaPedidosClientes.id_tipo_unidad =
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

  fechahora() {
    return Flexible(
        child: new Row(
      children: [
        Flexible(
          child: fechaRecojoInput('Fecha Recojo', fecharecojo),
        ),
        SizedBox(width: 10.0),
        Flexible(
          child: horaRecojoInput('Hora Recojo', horarecojo),
        ),
      ],
    ));
  }

  fechaRecojoInput(fechatext, controlador) {
    return TextField(
      cursorColor: Colors.blueAccent,
      controller: controlador,
      obscureText: false,
      style: style,
      enabled: _isReadonly,
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
            initialDate: DateTime.parse(_listaPedidosClientes.fecha),
            firstDate: DateTime(2015),
            lastDate: DateTime(2050));
        print(pickedDate);
        if (pickedDate != null && pickedDate != currentDate)
          setState(() {
            currentDate = pickedDate;
            String formattedTime = DateFormat('yyyy-MM-dd').format(pickedDate);
            fecharecojo.text = formattedTime.toString();

            _listaPedidosClientes.fecha = formattedTime;
          });
      },
    );
  }

  horaRecojoInput(fechatext, controlador) {
    return TextField(
      cursorColor: Colors.blueAccent,
      controller: controlador,
      obscureText: false,
      style: style,
      enabled: _isReadonly,
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

            _listaPedidosClientes.hora_recojo = formattedTime;
          });
      },
    );
  }
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
      //suggestionsCallback: ProviderLista.get_estados,
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
        // setState(() {
        //   _guiaRemAux.nombre_estado = suggestion.nombre_estado;
        //   _guiaRemAux.id_estado = suggestion.id_estado.toString();
        //   textAuxiliar.replaceAll('', suggestion.nombre_estado);
        // });
        // ScaffoldMessenger.of(context)
        //   ..removeCurrentSnackBar()
        //   ..showSnackBar(SnackBar(content: Text('${suggestion.id_estado}')));
      },
    ),
  );
}
