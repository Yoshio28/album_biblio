import 'package:album_biblio/model/album_biblio.dart';
import 'package:flutter/material.dart';

class AlbumLista extends StatefulWidget {
  const AlbumLista({super.key});

  @override
  State<AlbumLista> createState() => _AlbumListaState();
}

class _AlbumListaState extends State<AlbumLista> {
  int selectedAlbum = 0;
  late AlbumBiblio albumes;

  @override
  void initState() {
    super.initState();
    albumes = AlbumBiblio();
    albumes.addAlbum(
      Album(
        titulo: "Saccharine",
        artista: "VIOLENT VIRA",
        anio: 2025,
        gender: "Rock",
      ),
    );
    albumes.addAlbum(
      Album(
        titulo: "Common decency",
        artista: "VIOLENT VIRA",
        anio: 2025,
        gender: "Rock",
      ),
    );
    albumes.addAlbum(
      Album(
        titulo: "Burn me with a bibble",
        artista: "VIOLENT VIRA",
        anio: 2025,
        gender: "Rock",
      ),
    );
    albumes.addAlbum(
      Album(
        titulo: "Lolita",
        artista: "VIOLENT VIRA",
        anio: 2022,
        gender: "Rock",
      ),
    );
    albumes.addAlbum(
      Album(
        titulo: "Broken wings",
        artista: "Breathing Theory",
        anio: 2011,
        gender: "Rock",
      ),
    );
    albumes.addAlbum(
      Album(
        titulo: "Letting you go",
        artista: "Bullet For My Valentine",
        anio: 2018,
        gender: "Rock",
      ),
    );
    albumes.addAlbum(
      Album(titulo: "Memento", artista: "Nonoc", anio: 2020, gender: "Jpop"),
    );
    albumes.addAlbum(
      Album(
        titulo: "Eleventh-hour",
        artista: "EGOIST",
        anio: 2021,
        gender: "JPop",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Biblioteca de Álbumes")),
      body: RefreshIndicator(
        displacement: 40,
        edgeOffset: 20,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: _refrescar,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: ListTile.divideTiles(
            context: context,
            tiles: crearLista(),
            color: const Color.fromARGB(255, 255, 7, 7),
          ).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _refrescar() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {});
  }

  List<Widget> crearLista() {
    final List<Widget> lista = <Widget>[];
    for (int i = 0; i < albumes.albumes.length; i++) {
      Album album = albumes.albumes[i];
      lista.add(
        ListTile(
          leading: const Icon(Icons.album),
          title: Text(album.titulo),
          subtitle: Text(
            "${album.artista}, Año: ${album.anio}, Género:${album.gender}",
          ),
          trailing: SizedBox(
            width: 120,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: crearButtonsBar(i),
            ),
          ),
          selected: (selectedAlbum == i),
          onTap: () => albumTapped(i),
        ),
      );
    }
    return lista;
  }

  void albumTapped(int i) {
    setState(() {
      selectedAlbum = i;
    });
  }

  Widget crearButtonsBar(int index) {
    return Row(
      children: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
      ],
    );
  }
}
