import 'package:flutter/material.dart';
import '../model/album.dart';

class AlbumVista extends StatelessWidget {
  final Album album;

  const AlbumVista({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Datos del Álbum")),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(66, 196, 0, 0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(66, 196, 0, 0),
                  ),
                ),
                child: const Center(child: Text("IMAGEN")),
              ),
              const SizedBox(height: 16),

              infoRow(
                context,
                titulo: "Título:",
                valor: album.titulo,
                italic: true,
              ),
              infoRow(context, titulo: "Cantante:", valor: album.artista),
              infoRow(
                context,
                titulo: "Año de lanzamiento:",
                valor: album.anio.toString(),
              ),
              infoRow(context, titulo: "Género:", valor: album.genero),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoRow(
    BuildContext context, {
    required String titulo,
    required String valor,
    bool italic = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      margin: const EdgeInsets.only(bottom: 4),
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Row(
        children: [
          Text(
            titulo,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            valor,
            style: TextStyle(
              fontStyle: italic ? FontStyle.italic : FontStyle.normal,
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
