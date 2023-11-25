import 'package:Pegaso/src/data/db/token.dart';
import 'package:Pegaso/src/data/provider/providerLista.dart';
import 'package:Pegaso/src/pages/home/homeAg.dart';
import 'package:Pegaso/src/pages/home/homeAuxiliar.dart';
import 'package:Pegaso/src/util/app-config.dart';
import 'package:flutter/material.dart';
import 'package:Pegaso/src/Pages/Login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: LoadingScreen(),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var cantidad = 0;
  ProviderLista _providerLista = ProviderLista();
  mostrarDatos() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
/*    await DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getUltimoTokenle();
    cantidad = abc;

    print("mira $abc"); */

/*    if (abc == 1) {
      var a = await _providerLista.getLogin();

      if (a == 'Agente') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => HomePageAg()));
      } else {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => HomePageAux()));
      }
    } else {
      print(cantidad);
      
    } */
  }

  @override
  void initState() {
    //   _datdb.initDB();
    super.initState();
    getToken();
  }

  Future<int> getToken() async {
    await Future.delayed(const Duration(seconds: 10))
        .then((value) => mostrarDatos());
    // var abc = await _datdb.getAllTasks();

    return cantidad;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(-1, 133, 195, 206),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 155.0,
                child: Image.asset(
                  'assets/iconopegaso.png',
                  height: 90.0,
                  width: 300.0,
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                '',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              CircularProgressIndicator(
                backgroundColor: Colors.orange,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Home_Asis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}
