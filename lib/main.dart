import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/album_biblio.dart';
import 'views/album_lista.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => AlbumBiblio(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Biblioteca de Álbumes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AlbumLista(),
    );
  }
}
