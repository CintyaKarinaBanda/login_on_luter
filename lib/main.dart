//import 'package:counter/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_application/pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCtspMJkuzUaeVIVB7oCdOweopFXkFNkiI",
      authDomain: "flutterprueba-4845f.firebaseapp.com",
      projectId: "flutterprueba-4845f",
      storageBucket: "flutterprueba-4845f.appspot.com",
      messagingSenderId: "663278888782",
      appId: "1:663278888782:web:b0e01c19458f23f3e0e01f",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: LoginPage(),
    );
  }
}
