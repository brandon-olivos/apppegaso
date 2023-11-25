class Agente {
  final String cuenta;
  final int idAgente;

  const Agente({this.cuenta = '', this.idAgente = 0});

  static Agente fromJson(Map<String, dynamic> json) =>
      Agente(cuenta: json['cuenta'] +' '+ json['agente'], idAgente: json['id_agente']);
}
