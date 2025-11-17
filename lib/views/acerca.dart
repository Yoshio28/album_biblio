import 'package:flutter/material.dart';

class acerca extends StatelessWidget {
  const acerca({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Acerca de nosotros',
          style: TextStyle(fontFamily: 'Times New Roman'),
        ),
        backgroundColor: const Color.fromARGB(255, 114, 2, 2),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF121212),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color.fromARGB(255, 0, 21, 255),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('lib/assets/acerca.png'),
              ),
              SizedBox(height: 20),
              Text(
                'Disquera Godinez',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Times New Roman',
                  color: Colors.purpleAccent,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Correo: disqueraGodinez@gmail.com, Telefono: 662 109 1818',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(179, 237, 0, 0),
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              Divider(
                color: Color.fromARGB(255, 0, 60, 255),
                height: 30,
                thickness: 1,
              ),
              Text(
                'Somos una organización recopiladora de tus canciones favoritas al alcance de tu mano '
                'Amantes de las canciones rocks, J-Pop y la mezcla de las anteriores. '
                'Actualmente estudiamos la carrera de infromática y progresando en un curso de flutter.',
                style: TextStyle(fontSize: 14, color: Colors.white60),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
