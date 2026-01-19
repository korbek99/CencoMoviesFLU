import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
        backgroundColor: Colors.yellow,
      ),
      body: const Center(
        child: Text("Configuración de Perfil", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
