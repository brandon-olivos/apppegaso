import 'package:Pegaso/src/data/provider/providerLista.dart';
import 'package:Pegaso/src/data/provider/provider.dart';
import 'package:Pegaso/src/data/models/grclienteseguimiento.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class VerImagenGuiaClientePage extends StatefulWidget {
  List<GRClienteSeguimiento> guiaCliente;
  int id;

  VerImagenGuiaClientePage({this.id = 0, this.guiaCliente});

  @override
  _DetalleguiaedPageState createState() => _DetalleguiaedPageState();
}

class _DetalleguiaedPageState extends State<VerImagenGuiaClientePage> {
  var _image;
  String lastSelectedValue = "";
  String fotonomm = 'assets/pegasologo.png';

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 17.0);

  final _provider = new Provider();
  final _providerlista = new ProviderLista();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GRC: ${widget.guiaCliente[widget.id].guia_cliente}'),
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
                        _tomarImagen,
                      ],
                    ),
                  ])))),
    );
  }

  Widget get _tomarImagen {
    //
    //Future.delayed(Duration(seconds: 4));
    //
    return Center(
      child: Stack(
        alignment: Alignment(0.9, 1.1),
        children: <Widget>[
          Container(
            height: 380,
            width: 390,
            margin: EdgeInsets.only(right: 10.0, left: 10.2),
            child: Material(
              elevation: 4.0,
              child: new ClipRRect(
                  child: _image == null
                      ? new GestureDetector(
                          child: new Container(
                              height: 80.0,
                              width: 80.0,
                              child: new FadeInImage.assetNetwork(
                                  placeholder: fotonomm,
                                  imageErrorBuilder: (BuildContext context,
                                      Object exception, StackTrace stackTrace) {
                                    return Image.asset(fotonomm);
                                  },
                                  image:
                                      '${widget.guiaCliente[widget.id].nombre_ruta}')))
                      : new GestureDetector(
                          child: new Container(
                          height: 80.0,
                          width: 80.0,
                          child: Image.file(
                            _image,
                            fit: BoxFit.cover,
                            height: 800.0,
                            width: 80.0,
                          ),
                        ))),
            ),
          ),
        ],
      ),
    );
  }
}
