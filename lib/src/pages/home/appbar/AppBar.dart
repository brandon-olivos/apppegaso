import 'package:Pegaso/src/data/db/token.dart';
import 'package:Pegaso/src/pages/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:decorative_app_bar/decorative_app_bar.dart';

// ignore: use_key_in_widget_constructors
class AppBarPegaso extends StatefulWidget {
  @override
  _AppBarPegasoState createState() => _AppBarPegasoState();
}

class _AppBarPegasoState extends State<AppBarPegaso> {
  Widget text() {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: EdgeInsets.only(top: 40, left: 20),
          child: SizedBox(
            height: 70.0,
            child: Image.asset(
              'assets/logopegaso.png',
              height: 90.0,
              width: 300.0,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(top: 45, right: 20),
            child: Container(
              child: InkWell(
                onTap: () async {
                  await DatabasePr.db.eliminarTokn();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: Icon(
                  Icons.login,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
            )),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: DecorativeAppBar(
          barHeight: 300,
          barPad: 130,
          radii: 100,
          background: Colors.white,
          gradient1: Colors.indigo[900],
          gradient2: Colors.lightBlue[200],
          extra: text(),
        ));
  }
}
