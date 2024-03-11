// ignore_for_file: file_names
import 'package:flutter/material.dart'; 

class OlvideMiContrasena extends StatefulWidget {
  const OlvideMiContrasena({super.key});

  @override
  State<OlvideMiContrasena> createState() => _OlvideMiContrasenaState();
}

class _OlvideMiContrasenaState extends State<OlvideMiContrasena> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Cambiar el color del AppBar a azul
        title: const Text(
          "Recuperar Contraseña",
          textAlign: TextAlign.center, // Centrar el texto
        ),
        centerTitle: true, // Centrar el título
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navegar de vuelta a la página de login
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centrar los elementos verticalmente
          children: [
            Text(
              "Página para recuperar contraseña",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center, // Centrar el texto horizontalmente
            ),
            // Aquí puedes agregar más widgets según tus necesidades
          ],
        ),
      ),
    );
  }
}
