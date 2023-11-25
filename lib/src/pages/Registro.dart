import 'package:flutter/material.dart';
import 'package:Pegaso/src/Pages/Login/login.dart';

class RegistroPage extends StatelessWidget {
  TextEditingController dni = new TextEditingController();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final _dni = TextField(
      controller: dni,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Dni",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final _nombres = TextField(
      controller: dni,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Nombres",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final _apellidos = TextField(
      controller: dni,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Apellidos",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final _celular = TextField(
      controller: dni,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Celular",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final _correo = TextField(
      controller: dni,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Correo",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final contrasenia = TextField(
      controller: dni,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Contraseña",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final direccion = TextField(
      controller: dni,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Dirección",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final registro = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff7A56D0),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        },
        child: Text("Registrar",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff7A56D0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("REGISTRO DE DATOS")],
          ),
        ),
        body: Center(
          child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    SizedBox(height: 45.0),
                    _dni,
                    SizedBox(height: 20.0),
                    _nombres,
                    SizedBox(height: 20.0),
                    _apellidos,
                    SizedBox(height: 20.0),
                    _celular,
                    SizedBox(height: 20.0),
                    direccion,
                    SizedBox(height: 20.0),
                    _correo,
                    SizedBox(height: 20.0),
                    contrasenia,
                    SizedBox(height: 20.0),
                    registro,
                    SizedBox(height: 20.0),
                  ],
                ),
              )),
        ));
  }
}
