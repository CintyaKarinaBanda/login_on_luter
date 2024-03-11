  // ignore_for_file: library_private_types_in_public_api, avoid_print, use_build_context_synchronously

  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';
  import 'package:google_sign_in/google_sign_in.dart';
  import 'package:login_application/auth.dart';
  import 'package:login_application/pages/home_page.dart';
  import 'package:login_application/pages/olvide_contrasena.dart';
  import 'package:login_application/pages/registro_page.dart';

  class LoginPage extends StatefulWidget {
    const LoginPage({super.key});

    @override
    _LoginPageState createState() => _LoginPageState();
  }

  class _LoginPageState extends State<LoginPage> {
    @override
    Widget build(BuildContext context) {
      return const Scaffold(
        body: Stack(
          children: [
            Fondo(),
            Contenido(),
          ],
        ),
      );
    }
  }

  class Fondo extends StatelessWidget {
    const Fondo({super.key});

    @override
    Widget build(BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.blue],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
        ),
      );
    }
  }

  class Contenido extends StatefulWidget {
    const Contenido({
      super.key,
    });

    @override
    _ContenidoState createState() => _ContenidoState();
  }

  class _ContenidoState extends State<Contenido> {
    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "Bienvenido a tu cuenta",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 10),
            const Datos(),
            const SizedBox(height: 30),
            Container(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegistroPage(),
                    ),
                  );
                },
                child: const Text(
                  "Registrarse",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  class Datos extends StatefulWidget {
    const Datos({
      super.key,
    });

    @override
    State<Datos> createState() => _DatosState();
  }

  class _DatosState extends State<Datos> {
    final TextEditingController controllerEmail = TextEditingController();
    final TextEditingController controllerPassword = TextEditingController();
    String? errorMessage = '';

    Future<void> signInWithEmailAndPassword({required String email, required String password}) async {
        print(controllerEmail.text);
        print(controllerPassword.text);
      try {
        await Auth().signInWithEmailAndPassword(          
          email: controllerEmail.text,
          password: controllerPassword.text,
        );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
      } on FirebaseAuthException catch (e) {
        setState(() {
          errorMessage = e.message;
        });
      }
    }


    bool showPassword = true;

    @override
    Widget build(BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Correo",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: controllerEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "correo@correo.com",
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Contraseña",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: controllerPassword,
              obscureText: showPassword,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "password",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.remove_red_eye_outlined),
                    onPressed: () => {
                      setState(() {
                        showPassword == true
                            ? showPassword = false
                            : showPassword = true;
                      })
                    },
                  )),
            ),
            const SizedBox(
              height: 5,
            ),
            const Remember(),
            const SizedBox(
              height: 5,
            ),
            Botones(
              emailController: controllerEmail,
              passwordController: controllerPassword,
            ),
          ],
        ),
      );
    }
  }

  class Remember extends StatefulWidget {
    const Remember({super.key});

    @override
    State<Remember> createState() => _RememberState();
  }

  class _RememberState extends State<Remember> {
    bool checked = false;

    @override
    Widget build(BuildContext context) {
      return Row(
        children: [
          Checkbox(
            value: checked,
            onChanged: (isChecked) {
              setState(() {
                checked = isChecked ?? false;
              });
            },
          ),
          const Text(
            "Recordar cuenta",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OlvideMiContrasena(),
                ),
              );
            },
            child: const Text(
              "¿Olvidó su contraseña?",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      );
    }
  }

  class Botones extends StatelessWidget {
    final TextEditingController emailController;
    final TextEditingController passwordController;

    Future<void> signInWithGoogle(BuildContext context) async {
      try {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        if (googleUser == null) {
          return;
        }

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);

        User? user = Auth().currentUser;
        if (user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        } else {
          print("Inicio de sesión con Google fallido.");
        }
      } catch (e) {
        print("Error signing in with Google: $e");
      }
    }

    const Botones({
      super.key,
      required this.emailController,
      required this.passwordController,
    });

    @override
    Widget build(BuildContext context) {
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Auth().signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text,
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xff142047)),
              ),
              child: const Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
            width: double.infinity,
          ),
          const Text(
            "O entra con:",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 25,
            width: double.infinity,
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton(
              onPressed: () {
                signInWithGoogle(context);
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xff142047)),
              ),
              child: const Text(
                "Google",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
            width: double.infinity,
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton(
              onPressed: () async => {
                await Auth().signInWithFacebook()
              },
              child: const Text(
                "Facebook",
                style: TextStyle(
                    color: Color(0xff142047),
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
          const SizedBox(),
        ],
      );
    }
  }
