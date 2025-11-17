import 'package:flutter/material.dart';
import 'package:album_biblio/model/album.dart';

class AlbumForm extends StatefulWidget {
  final Album? album;
  const AlbumForm({super.key, this.album});

  @override
  State<AlbumForm> createState() => _AlbumFormState();
}

class _AlbumFormState extends State<AlbumForm> {
  final _formKey = GlobalKey<FormState>();
  final ctrTitulo = TextEditingController();
  final ctrArtista = TextEditingController();
  final ctrAnio = TextEditingController();
  Genre selectedGenre = Genre.undefined;
  late String tituloForm;

  @override
  void initState() {
    super.initState();
    if (widget.album != null) {
      ctrTitulo.text = widget.album!.titulo;
      ctrArtista.text = widget.album!.artista;
      ctrAnio.text = widget.album!.anio.toString();
      selectedGenre = widget.album!.genre;
      tituloForm = "Editar Álbum";
    } else {
      tituloForm = "Nuevo Álbum";
    }
  }

  @override
  void dispose() {
    ctrTitulo.dispose();
    ctrArtista.dispose();
    ctrAnio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tituloForm)),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: ctrTitulo,
                decoration: const InputDecoration(
                  labelText: 'Título del álbum',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) =>
                    valor == null || valor.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: ctrArtista,
                decoration: const InputDecoration(
                  labelText: 'Artista',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) =>
                    valor == null || valor.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: ctrAnio,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Año de lanzamiento',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.isEmpty)
                    return 'Campo obligatorio';
                  final anio = int.tryParse(valor);
                  if (anio == null || anio < 1700 || anio > 2025) {
                    return 'Ingrese un año válido (1700–2025)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              DropdownMenu<Genre>(
                initialSelection: selectedGenre,
                label: const Text("Género"),
                dropdownMenuEntries: genres.keys
                    .map(
                      (key) =>
                          DropdownMenuEntry(value: key, label: genres[key]!),
                    )
                    .toList(),
                onSelected: (valor) =>
                    setState(() => selectedGenre = valor ?? Genre.undefined),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.check),
                    label: const Text("Guardar"),
                    onPressed: _guardar,
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.close),
                    label: const Text("Cancelar"),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _guardar() {
    if (!_formKey.currentState!.validate()) return;
    final album = Album(
      id: widget.album?.id,
      titulo: ctrTitulo.text,
      artista: ctrArtista.text,
      anio: int.parse(ctrAnio.text),
      genre: selectedGenre,
    );
    Navigator.pop(context, album);
  }
}
