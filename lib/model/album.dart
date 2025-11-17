enum Genre {
  pop,
  latin,
  rock,
  classic,
  hiphop,
  rap,
  metal,
  jazz,
  blues,
  jpop,
  undefined,
}

Map<Genre, String> genres = {
  Genre.pop: "Pop",
  Genre.latin: "Latina",
  Genre.rock: "Rock",
  Genre.classic: "Clásica",
  Genre.hiphop: "Hip Hop",
  Genre.rap: "Rap",
  Genre.metal: "Metal",
  Genre.jazz: "Jazz",
  Genre.blues: "Blues",
  Genre.jpop: "J-Pop",
  Genre.undefined: "No definido",
};

class Album {
  int? id;
  String titulo;
  String artista;
  int anio;
  Genre genre;

  Album({
    this.id,
    required this.titulo,
    required this.artista,
    required this.anio,
    required this.genre,
  });

  Album.vacio({
    this.id = 0,
    this.titulo = "",
    this.artista = "",
    this.anio = 0,
    this.genre = Genre.undefined,
  });

  Album.fromMap(Map<String, dynamic> json)
    : id = json['id'],
      titulo = json['titulo'],
      artista = json['artista'],
      anio = json['anio'],
      genre = Genre.values.firstWhere(
        (g) => g.name == json['genre'],
        orElse: () => Genre.undefined,
      );

  Map<String, dynamic> toMap() => {
    'id': id,
    'titulo': titulo,
    'artista': artista,
    'anio': anio,
    'genre': genre.name,
  };

  String get genero => genres[genre] ?? "No definido";

  @override
  String toString() {
    return "Album{id: $id, titulo: $titulo, artista: $artista, anio: $anio, genre:${genre.name}}";
  }
}
