import 'package:Pegaso/src/Pages/SeguimientoAtencion/seg_atencion.dart';
import 'package:Pegaso/src/data/models/ListaseguimientoAgRC.dart';
import 'package:Pegaso/src/data/provider/providerLista.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SeguimientoAuxiliarClAux extends StatefulWidget {
  String idGuiaRem, tipo;

  SeguimientoAuxiliarClAux({this.idGuiaRem = '', this.tipo = ''});
  @override
  _SeguimientoAgenciaPageState createState() => _SeguimientoAgenciaPageState();
}

class _SeguimientoAgenciaPageState extends State<SeguimientoAuxiliarClAux> {
  final _providerLista = new ProviderLista();
  int body = 0;
  @override
  void initState() {
    super.initState();

    setState(() {
      refreshList();
      _providerLista.getConsultaGuiasRCAux(widget.idGuiaRem, widget.tipo);
    });
    _providerLista.getConsultaGuiasRCAux(widget.idGuiaRem, widget.tipo);
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 10));
    setState(() {
      _providerLista.getConsultaGuiasRCAux(widget.idGuiaRem, widget.tipo);
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      refreshList();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Guias',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.indigo[900],
        elevation: 1,
      ),
      body: FutureBuilder<List<ListaseguimientoAgRC>>(
        future:
            _providerLista.getConsultaGuiasRCAux(widget.idGuiaRem, widget.tipo),
        builder: (BuildContext context,
            AsyncSnapshot<List<ListaseguimientoAgRC>> snapshot) {
          if (!snapshot.hasData) {
            if (snapshot.hasData == false) {
              return Center(
                child: Text("¡No existen registros!"),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
          final listaPersonalAux = snapshot.data;

          if (listaPersonalAux?.length == 0) {
            return Center(
              child: Text("No hay informacion"),
            );
          } else {
            //   setState(() {});
            return Container(
                child: RefreshIndicator(
                    child: ListView.builder(
                      itemCount: listaPersonalAux?.length,
                      itemBuilder: (context, i) =>
                          _banTitle(listaPersonalAux[i], i),
                    ),
                    onRefresh: refreshList));
          }
        },
      ),
    );
  }

  ListTile _banTitle(ListaseguimientoAgRC band, i) {
    _providerLista.getConsultaGuiasRCAux(widget.idGuiaRem, widget.tipo);
    return ListTile(
      leading: CircleAvatar(
        child: Text(band.numero_guia.substring(0, 2)),
        backgroundColor: Colors.blue[900],
      ),
      title: Text(band.numero_guia, style: TextStyle(fontSize: 13)),
      subtitle: new Text(band.estado, style: TextStyle(fontSize: 13)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${band.tipo}',
            style: TextStyle(fontSize: 13),
          ),
          Container(
            width: 150,
            child: Text(
              '${band.fecha_reg}',
              style: TextStyle(fontSize: 13),
            ),
          )
        ],
      ),
      onTap: () async {
        var abc = await _providerLista.getConsultaGuiasRCAux(
            widget.idGuiaRem, widget.tipo);

        await Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => SegAtencionPage(
                  idGuiaRem: widget.idGuiaRem,
                  titulo: band.numero_guia,
                  idGuia: band.id_guia_remision,
                  tipo: band.tipo,
                  recibido_por: abc[i].recibido_por,
                  nombre_ruta: abc[i].nombre_ruta,
                  observacion: abc[i].observacion)),
        );
      },
    );
  }

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
}
