import 'dart:async';
import 'dart:convert';
import 'package:Pegaso/src/Pages/home/homeAg.dart';
import 'package:Pegaso/src/Pages/home/homeAuxiliar.dart';
import 'package:Pegaso/src/Pages/home/homeSistema.dart';
import 'package:Pegaso/src/data/db/token.dart';
import 'package:Pegaso/src/data/provider/providerLista.dart';
import 'package:Pegaso/src/pages/home/homeClientes.dart';
import 'package:Pegaso/src/pages/home/homeOperacionesInicio.dart';
import 'package:Pegaso/src/pages/home/homeVentas.dart';
import 'package:Pegaso/src/util/app-config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:Pegaso/src/Pages/Login/modelLogin.dart';
import '../Registro.dart';

class LoginPage extends StatefulWidget {
  static String route = '/';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    DatabasePr.db.initDB();
  }

  TokenUsuario token;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController email = new TextEditingController();
  ProviderLista _providerLista = ProviderLista();

  TextEditingController password = new TextEditingController();

  Future<TokenUsuario> LoginUser(usn, psw) async {
    print(usn);
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil + '/login/rest/login'),
        body: {
          "usuario": "$usn",
          "password": "$psw",
          "grant_type": "password"
        });
    print(response.body);
    var jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      token = new TokenUsuario.fromJson(jsonResponse);
      await DatabasePr.db.initDB();
      final rspt = TokenUsuario(estado: token?.estado, token: token?.token);
      await DatabasePr.db.insertToken(rspt);

      if (token?.estado == true) {
        print(token?.estado);
        var a = await _providerLista.getLogin();
        var b = await _providerLista.getLoginUusario();
        //    a[2].toString();

        if (a == 'Agente') {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) => HomePageAg()));
        } else if (a == 'Auxiliar') {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => HomePageAux()));
        } else if (a == 'OPERACIONES - INICIO') {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => HomeOperacionesInicio(b)));
        }

        ////
        //22/11/2022
        else if (a == 'Ventas') {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) => HomeVentas()));
        }
        //22/11/2022
        ///
        ///
        ///

        //12/06/2023
        else if (a == 'Clientes') {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => HomeClientes()));
        }
        //12/06/2023
        ///

        return TokenUsuario.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
          msg: 'Usuario o contraseña incorrectos',
          gravity: ToastGravity.BOTTOM,
        );
      }
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(
        msg: 'Usuario o contraseña incorrectos',
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      CircularProgressIndicator(
        value: null,
        strokeWidth: 7.0,
      );
    }
    return token;
  }

  @override
  Widget build(BuildContext context) {
    DatabasePr.db.initDB();
    final emailField = TextField(
      cursorColor: Colors.indigo[900],
      controller: email,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          hoverColor: Colors.indigo[900],
          fillColor: Colors.indigo[900],
          focusColor: Colors.indigo[900],
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Usuario",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      controller: password,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Contraseña",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.indigo[900],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          await DatabasePr.db.eliminarTokn();

          LoginUser(email.text, password.text);
        },
        child: Text("Iniciar sesión",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    final registro = Material(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => RegistroPage(),
            ),
          );
        },
        child: Text("Registro",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.black, fontWeight: FontWeight.bold)),
      ),
    );
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: ListView(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(
                    height: 155.0,
                    child: Image.asset(
                      'assets/pegasologo.png',
                      height: 90.0,
                      width: 300.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 45.0),
                  emailField,
                  SizedBox(height: 25.0),
                  passwordField,
                  SizedBox(
                    height: 35.0,
                  ),
                  loginButon,
                  SizedBox(
                    height: 15.0,
                  ),
                  //  registro,
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
