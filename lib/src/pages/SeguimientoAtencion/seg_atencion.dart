// ignore_for_file: sized_box_for_whitespace, unnecessary_new

import 'dart:convert';
import 'dart:io';

import 'package:Pegaso/src/Pages/Seguimiento/seguimiento_agencia/SeguimientoAgCl.dart';
import 'package:Pegaso/src/data/provider/providerLista.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class SegAtencionPage extends StatefulWidget {
  String titulo;
  String idGuia, tipo, idGuiaRem, observacion, recibido_por, nombre_ruta;

  SegAtencionPage(
      {this.titulo = '',
      this.idGuia = '',
      this.idGuiaRem = '',
      this.tipo = '',
      this.recibido_por = '',
      this.nombre_ruta = '',
      this.observacion = ''});

  @override
  _SegAtencionPageState createState() => _SegAtencionPageState();
}

class _SegAtencionPageState extends State<SegAtencionPage> {
  File _imageby;
  var _image;
  String image64 = '';
  String lastSelectedValue = "", nombre_2 = "", iamgen_file = "";
  String textofield = '';
  List<String> nombre_ = [];
  String fotonomm = 'assets/pegasologo.png';

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  TextEditingController observacion = new TextEditingController();
  TextEditingController recibidopor = new TextEditingController();
  final _providerLista = new ProviderLista();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.indigo[900],
        elevation: 1,
      ),
      body: _formulario(),
    );
  }

  var nuevo = '';

  var obsnuevo = '';
  imputField(texto, controladors) {
    //  controladors = TextEditingController(text: inicial);
    return TextFormField(
      textInputAction: TextInputAction.go,

      onChanged: (value) {
        // recepcion.text = value.toString();
        nuevo = value.toString();
        //   controladors.text = value;
      },

      cursorColor: Color(0xFF3949AB),
      controller: controladors,
      // initialValue: "ss",
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          labelText: texto,
          fillColor: Color(0xFF3949AB),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: texto,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hoverColor: Color(0xFF3949AB),
          focusColor: Color(0xFF3949AB)),
    );
  }

  void showDemoActionSheet({BuildContext context, Widget child}) {
    showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) => child,
    ).then((String value) {
      if (value = null) {
        setState(() {
          lastSelectedValue = value;
        });
      }
    });
  }

  selectCamera() {
    showDemoActionSheet(
      context: context,
      child: CupertinoActionSheet(
          title: const Text('Seleccionar Camara'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: const Text('Camara'),
              onPressed: () {
                Navigator.pop(context, 'Camara');
                cameraImage();
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Galeria'),
              onPressed: () {
                Navigator.pop(context, 'Galeria');
                getImageLibrary();
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancelar'),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, 'Cancelar');
            },
          )),
    );
  }

  guardar() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.blue[900],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          await _providerLista.subirImagen(
              idGuiaRem: widget.idGuiaRem,
              idGuia: widget.idGuia,
              tipo: widget.tipo,
              comentario: observacion.text,
              recibido_por: recibidopor.text,
              imagen: image64);
          setState(() {
            _providerLista.getConsultaGuiasRC(widget.idGuiaRem, widget.tipo);
          });

          await Navigator.of(context, rootNavigator: true)
              .maybePop(MaterialPageRoute(
                  builder: (context) => SeguimientoAgClPage(
                        idGuiaRem: widget.idGuiaRem,
                      )));

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

  _formulario() {
    //  setState(() {});
    //recepcion.text = widget.recibido_por.toString();
    // textofield = widget.recibido_por.toString();
    if (widget.observacion == null) {
      observacion.text;
    } else if (widget.observacion == '') {
    } else if (widget.observacion != null) {
      if (obsnuevo != '') {
        observacion.text = obsnuevo;
      } else {
        observacion.text = widget.observacion.toString();
      }
    }
    if (widget.recibido_por == null) {
      recibidopor.text;
    } else if (widget.recibido_por == '') {
    } else if (widget.recibido_por != null) {
      if (nuevo != '') {
        recibidopor.text = nuevo;
      } else {
        recibidopor.text = widget.recibido_por.toString();
      }
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 0.0),
            Column(
              children: <Widget>[
                _tomarImagen,
                SizedBox(height: 20.0),
                imputField('Recibido por', recibidopor),
                SizedBox(height: 20.0),
                imputField('Observacion', observacion),

                /*, */
                SizedBox(
                  height: 20.0,
                ),
                guardar()
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ]),
    );
  }

/*void _setImage() async {
    _imageby = File(await ImagePicker().pickImage(
      source: ImageSource?.camera).then((pickedFile) =>  pickedFile.path));
} */
  Future cameraImage() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 700);
    setState(() {
      _imageby = File(image.path);

      _image = File(image.path);
    });
    List<int> bytes = File(_imageby.path).readAsBytesSync();

    image64 = base64Encode(bytes);
  }

  Future getImageLibrary() async {
    var gallery = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 700);
    setState(() {
      _imageby = File(gallery.path);
      _image = File(gallery.path);
    });
    List<int> bytes = await new File(_imageby.path).readAsBytesSync();
    image64 = base64Encode(bytes);
  }

  Widget get _tomarImagen {
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
              //    borderRadius: BorderRadius.circular(100.0),
              // ignore: unnecessary_new
              child: new ClipRRect(
                  //     borderRadius: new BorderRadius.circular(100.0),
                  child: _image == null
                      ? new GestureDetector(
                          onTap: () {
                            selectCamera();
                          },
                          child: new Container(
                              height: 80.0,
                              width: 80.0,
                              // color: primaryColor,
                              child: new FadeInImage.assetNetwork(
                                  placeholder: fotonomm,
                                  imageErrorBuilder: (BuildContext context,
                                      Object exception, StackTrace stackTrace) {
                                    return Image.asset(fotonomm);
                                  },
                                  image: '${widget.nombre_ruta}')))
                      : new GestureDetector(
                          onTap: () {
                            selectCamera();
                          },
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
