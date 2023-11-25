import 'package:Pegaso/src/data/models/GuiaRemAux.dart';
import 'package:Pegaso/src/data/provider/providerGRElectronica.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class VerEstadoImprimirGuiaPage extends StatefulWidget {
  final String numSerie;
  final String numGuia;

  VerEstadoImprimirGuiaPage({this.numSerie = "", this.numGuia = ""});

  @override
  State<VerEstadoImprimirGuiaPage> createState() =>
      _VerEstadoImprimirGuiaPageState();
}

class _VerEstadoImprimirGuiaPageState extends State<VerEstadoImprimirGuiaPage> {
  final PageController _pageController = PageController();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  TextEditingController numero_guia_txt = TextEditingController();
  TextEditingController numero_serie_txt = TextEditingController();

  TextEditingController aceptadaPorSunat = TextEditingController();
  TextEditingController sunatDescription = TextEditingController();
  TextEditingController sunatNote = TextEditingController();
  TextEditingController sunatResponsecode = TextEditingController();
  TextEditingController sunatSoapError = TextEditingController();
  TextEditingController enlaceDePdf = TextEditingController();

  final _providerGRElectronica = new ProviderGRElectronica();

  var dato;
  var tamanioboton = 50.0;
  var aceptada = '';

  GuiaRemAux _guiaRemAux = GuiaRemAux();

  Future refreshList() async {
    print(widget.numGuia);
    int numero = int.parse(widget.numGuia);
    await Future.delayed(Duration(seconds: 1));
    var a = await _providerGRElectronica.getVerEstadoGuia(numero);
    setState(() {
      _guiaRemAux = a;
      //print(_guiaRemAux.idGuiaRemision);
      aceptada = _guiaRemAux.aceptada_por_sunat.toString();
      numero_guia_txt.text = widget.numGuia;
      numero_serie_txt.text = widget.numSerie;
    });
  }

  Map<String, String> get headers {
    //tokenUsuario.toMap(DatabasePr.db.getUltimoToken());

    return {
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
    if (_guiaRemAux.aceptada_por_sunat == 'SI') {
      aceptadaPorSunat.text = "ACEPTADA";
      enlaceDePdf.text = _guiaRemAux.enlace_del_pdf.toString();
    } else {
      aceptadaPorSunat.text = "NO ACEPTADA";
      sunatDescription.text = _guiaRemAux.sunat_description.toString();
      sunatNote.text = _guiaRemAux.sunat_note.toString();
      sunatResponsecode.text = _guiaRemAux.sunat_responsecode.toString();
      sunatSoapError.text = _guiaRemAux.sunat_soap_error.toString();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Imprimir GRE'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.indigo[900],
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
                  SizedBox(height: 12.0),
                  numero_guia_serie(),
                  SizedBox(height: 12.0),
                  aceptada_por_sunat_input(),
                  //OK
                  SizedBox_Aceptada(),
                  boton_imprimir_pdf(),
                  //ERROR
                  SizedBox_No_Aceptada(),
                  sunat_descripcion_input(),
                  SizedBox_No_Aceptada(),
                  sunatSoapError_input(),
                  SizedBox_No_Aceptada(),
                  sunatResponsecode_input(),
                  SizedBox_No_Aceptada(),
                  sunatNote_input(),
                  //
                  SizedBox(height: 12.0),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  SizedBox_Aceptada() {
    if (aceptada == "SI") {
      return SizedBox(height: 12.0);
    } else {
      return SizedBox(height: 0);
    }
  }

  SizedBox_No_Aceptada() {
    if (aceptada == "NO") {
      return SizedBox(height: 12.0);
    } else {
      return SizedBox(height: 0);
    }
  }

  numero_guia_serie() {
    return Flexible(
        child: new Row(
      children: [
        Flexible(
          child: new TextField(
            enabled: false,
            cursorColor: Colors.blueAccent,
            obscureText: false,
            controller: numero_serie_txt,
            keyboardType: TextInputType.text,
            style: style,
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
            controller: numero_guia_txt,
            obscureText: false,
            style: style,
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

  aceptada_por_sunat_input() {
    if (aceptada == "SI") {
      return TextField(
        cursorColor: Colors.blueAccent,
        keyboardType: TextInputType.text,
        obscureText: false,
        enabled: false,
        maxLines: 1,
        style: style,
        controller: aceptadaPorSunat,
        decoration: InputDecoration(
            labelText: 'Aceptada por SUNAT',
            fillColor: Colors.blueAccent,
            contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 20.0, 15.0),
            hintText: 'Aceptada por SUNAT',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      );
    } else {
      return SizedBox(height: 0);
    }
  }

  boton_imprimir_pdf() {
    if (aceptada == "SI") {
      return Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.blue[900],
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
            launchUrl(Uri.parse(_guiaRemAux.enlace_del_pdf),
                mode: LaunchMode.externalApplication);
          },
          child: Text("IMPRIMIR GUIA",
              textAlign: TextAlign.center,
              style: style.copyWith(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
      );
    } else {
      return SizedBox(height: 0);
    }
  }

  //
  ///
  sunat_descripcion_input() {
    if (aceptada == "NO") {
      return TextField(
        cursorColor: Colors.blueAccent,
        keyboardType: TextInputType.text,
        obscureText: false,
        enabled: false,
        maxLines: 1,
        style: style,
        controller: sunatDescription,
        decoration: InputDecoration(
            labelText: 'Descripcion de SUNAT',
            fillColor: Colors.blueAccent,
            contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 20.0, 15.0),
            hintText: 'Descripcion de SUNAT',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      );
    } else {
      return SizedBox(height: 0);
    }
  }

  sunatNote_input() {
    if (aceptada == "NO") {
      return TextField(
        cursorColor: Colors.blueAccent,
        keyboardType: TextInputType.text,
        obscureText: false,
        enabled: false,
        maxLines: 3,
        style: style,
        controller: sunatNote,
        decoration: InputDecoration(
            labelText: 'SUNAT Note',
            fillColor: Colors.blueAccent,
            contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 20.0, 15.0),
            hintText: 'Descripcion de SUNAT',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      );
    } else {
      return SizedBox(height: 0);
    }
  }

  sunatResponsecode_input() {
    if (aceptada == "NO") {
      return TextField(
        cursorColor: Colors.blueAccent,
        keyboardType: TextInputType.text,
        obscureText: false,
        enabled: false,
        maxLines: 1,
        style: style,
        controller: sunatResponsecode,
        decoration: InputDecoration(
            labelText: 'SUNAT Response Code',
            fillColor: Colors.blueAccent,
            contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 20.0, 15.0),
            hintText: 'SUNAT Response Code',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      );
    } else {
      return SizedBox(height: 0);
    }
  }

  sunatSoapError_input() {
    if (aceptada == "NO") {
      return TextField(
        cursorColor: Colors.blueAccent,
        keyboardType: TextInputType.text,
        obscureText: false,
        enabled: false,
        maxLines: 9,
        style: style,
        controller: sunatSoapError,
        decoration: InputDecoration(
            labelText: 'SUNAT Soap Error',
            fillColor: Colors.blueAccent,
            contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 20.0, 15.0),
            hintText: 'SUNAT Soap Error',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      );
    } else {
      return SizedBox(height: 0);
    }
  }
}
