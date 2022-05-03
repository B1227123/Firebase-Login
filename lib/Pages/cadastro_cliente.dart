import 'package:firebase_app/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: _initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return LoginScreen();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "usuário-não-encontrado") {
        print("Nenhum usuário encontrado com este e-mail");
      }
    }

    return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Costura 4.0",
              style: TextStyle(
                color: Colors.black,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Faça login para continuar",
              style: TextStyle(
                color: Colors.black,
                fontSize: 44.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 44.0,
            ),
            TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    hintText: "E-mail do usuário",
                    prefixIcon: Icon(Icons.mail, color: Colors.black))),
            const SizedBox(
              height: 26.0,
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Senha",
                prefixIcon: Icon(Icons.lock, color: Colors.black),
              ),
            ),
            const SizedBox(height: 12.0),
            const Text(
              "Esqueceu sua senha?",
              style: TextStyle(color: Colors.blue),
            ),
            const SizedBox(
              height: 88.0,
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: const Color(0xFF0069FE),
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular((12.0))),
                onPressed: () async {
User? user = await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
print(user);
if(user != null){
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> ProfileScreen()));
}
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
