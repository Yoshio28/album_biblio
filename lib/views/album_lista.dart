import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:album_biblio/model/album.dart';
import 'package:album_biblio/model/album_biblio.dart';
import 'package:album_biblio/model/ManejadorDatabase.dart';
import 'album_vista.dart';
import 'album_form.dart';
import 'perfil_usuario.dart';
import 'Acerca.dart';

class AlbumLista extends StatefulWidget {
  const AlbumLista({super.key});

  @override
  State<AlbumLista> createState() => _AlbumListaState();
}

class _AlbumListaState extends State<AlbumLista> {
  bool dbRead = false;
  late AlbumBiblio albumes;
  late ManejadorDatabase manejadorDB;

  @override
  void initState() {
    super.initState();
    manejadorDB = ManejadorDatabase.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    albumes = Provider.of<AlbumBiblio>(context);

    if (!dbRead) {
      manejadorDB.albumes().then((value) {
        albumes.setAlbumes(value);
        setState(() => dbRead = true);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Biblioteca de Álbumes"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => const [
              PopupMenuItem(value: 1, child: Text("Perfíl del usuario")),
              PopupMenuItem(value: 2, child: Text("Acerca de...")),
            ],
            onSelected: (value) {
              if (value == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PerfilUsuario(),
                  ),
                );
              } else if (value == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const acerca()),
                );
              }
            },
          ),
        ],
      ),
      body: !dbRead
          ? const Center(child: CircularProgressIndicator())
          : albumes.albumes.isEmpty
          ? Center(
              child: ElevatedButton(
                onPressed: () => capturarAlbum(context),
                child: const Text("Agregar Álbum"),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(10),
              children: ListTile.divideTiles(
                context: context,
                tiles: crearLista(),
                color: Colors.grey,
              ).toList(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => capturarAlbum(context),
        tooltip: 'Nuevo álbum',
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Widget> crearLista() {
    return List.generate(albumes.albumes.length, (i) {
      final album = albumes.albumes[i];
      return ListTile(
        leading: const Icon(Icons.album),
        title: Text(album.titulo),
        subtitle: Text(
          "${album.artista}, Año: ${album.anio}, Género: ${album.genero}",
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: "Ver",
              onPressed: () => mostrarAlbum(context, i),
              icon: const Icon(Icons.search),
            ),
            IconButton(
              tooltip: "Editar",
              onPressed: () => actualizarAlbum(context, i),
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              tooltip: "Eliminar",
              onPressed: () => removerAlbum(context, i),
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      );
    });
  }

  Future<void> capturarAlbum(BuildContext context) async {
    final album = await Navigator.push<Album>(
      context,
      MaterialPageRoute(builder: (_) => const AlbumForm()),
    );
    if (album != null) {
      final id = await manejadorDB.insertarAlbum(album);
      album.id = id;
      albumes.addAlbum(album);
    }
  }

  Future<void> actualizarAlbum(BuildContext context, int index) async {
    final albumEditado = await Navigator.push<Album>(
      context,
      MaterialPageRoute(
        builder: (_) => AlbumForm(album: albumes.getAlbumByIndex(index)),
      ),
    );
    if (albumEditado != null) {
      albumes.updateAlbum(index, albumEditado);
      await manejadorDB.actualizarAlbum(albumEditado);
    }
  }

  Future<void> removerAlbum(BuildContext context, int index) async {
    final album = albumes.getAlbumByIndex(index);
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Eliminar álbum"),
        content: const Text("¿Deseas eliminar este álbum?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Confirmar"),
          ),
        ],
      ),
    );

    if (confirmar == true) {
      await manejadorDB.removerAlbum(album.id!);
      albumes.removeAlbum(index);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Álbum eliminado correctamente")),
        );
      }
    }
  }

  void mostrarAlbum(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AlbumVista(album: albumes.getAlbumByIndex(index)),
      ),
    );
  }
}
