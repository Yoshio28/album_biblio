import 'package:flutter/material.dart';

class PerfilUsuario extends StatelessWidget {
  const PerfilUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil de Usuario',
          style: TextStyle(fontFamily: 'Times New Roman'),
        ),
        backgroundColor: const Color(0xFF2B2B2B),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF121212),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.purpleAccent, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.purpleAccent.withOpacity(0.5),
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
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
              SizedBox(height: 20),
              Text(
                'Jovan Eduardo Correa Cabral',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Times New Roman',
                  color: Colors.purpleAccent,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Correo: Yoshiokun8@gmail.com, Telefono: 662 108 1717',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              Divider(color: Colors.purpleAccent, height: 30, thickness: 1),
              Text(
                'Apasionado por crear aplicaciones hibridas para complementar su avance en desarrollo web '
                'Amante de los temas oscuros en aplicaciones y la documentación de proyectos. '
                'Actualmente estudiando la carrera de infromática e incursionando en un curso de flutter.',
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
