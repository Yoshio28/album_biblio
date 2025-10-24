import 'package:flutter/material.dart';
import 'package:album_biblio/views/album_vista.dart';
import 'package:album_biblio/views/perfil_usuario.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo Album',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: AlbumVista(),
    );
  }
}
