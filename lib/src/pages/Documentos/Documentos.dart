import 'package:Pegaso/src/pages/Documentos/ControlKilometraje/ControlKilometraje.dart';
import 'package:Pegaso/src/pages/Documentos/RendicionCuentas/RendicionCuentas.dart';
import 'package:flutter/material.dart';

class DocumentosPage extends StatefulWidget {
  String titulo;

  DocumentosPage({this.titulo});
  @override
  State<DocumentosPage> createState() => _DocumentosPageState();
}

class _DocumentosPageState extends State<DocumentosPage> {
  int currenIndex = 0;
  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

    botones(nombre, icono) {
      return InkWell(
        onTap: () {
          switch (nombre) {
            case 'Rendicion de cuentas':
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RendicionCuentasPage(
                          titulo: nombre,
                        )),
              );
              break;
            case 'Control Kilometraje':
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ControlKilometrajePage(
                        // titulo: nombre,
                        )),
              );
              break;
          }
        },
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    icono,
                    color: Colors.orange,
                    size: 60,
                  ),
                ],
              ),
              ListTile(
                title: Center(
                    child: Text("" + nombre,
                        textAlign: TextAlign.center,
                        style: style.copyWith(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold))),
              ),
            ],
          ),
        ),
      );
    }

    List listPages = [
      Container(
          child: Column(
        children: <Widget>[
          Expanded(
              flex: 6,
              child: Center(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Center(
                      child: GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        //shrinkWrap: true,
                        /*  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,*/
                        children: [
                          botones(
                              "Rendicion de cuentas", Icons.checklist_rounded),
                          botones(
                              "Control Kilometraje", Icons.app_registration),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ],
      )),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.indigo[900],
        title: Text(
          '${widget.titulo}',
          style: TextStyle(color: Colors.white),
        ),
        actions: [],
        elevation: 1,
      ),
      //body: listPages[currenIndex]);
      body: Stack(
        children: <Widget>[listPages[currenIndex]],
      ),
    );
  }
}
