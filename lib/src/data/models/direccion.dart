class Direccion {
  final String direccion;
  final String id_direccion;
  final String id_entidad;

  const Direccion(
      {this.direccion = '', this.id_direccion = '', this.id_entidad = ''});

  static Direccion fromJson(Map<String, dynamic> json) => Direccion(
        direccion: json['direccion'],
        id_direccion: json['id_direccion'],
        id_entidad: json['id_entidad'],
      );
}

class DireccionesMod {
  int id_direccion;
  int id_entidad;
  int id_ubigeo;
  String direccion;

  DireccionesMod({
    this.id_direccion = 0,
    this.id_entidad = 0,
    this.id_ubigeo = 0,
    this.direccion = '',
  });

  factory DireccionesMod.fromMap(Map<String, dynamic> obj) => DireccionesMod(
        id_direccion: obj['id_direccion'],
        id_entidad: obj['id_entidad'],
        id_ubigeo: obj['id_ubigeo'],
        direccion: obj['direccion'],
      );

  factory DireccionesMod.fromJson(Map<String, dynamic> obj) {
    return DireccionesMod(
      id_direccion: obj['id_direccion'],
      id_entidad: obj['id_entidad'],
      id_ubigeo: obj['id_ubigeo'],
      direccion: obj['direccion'],
    );
  }
}
