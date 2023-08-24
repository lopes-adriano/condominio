import 'package:condominio/screens/carros_morador.dart';
import 'package:condominio/screens/home_screen.dart';
import 'package:condominio/screens/read_users.dart';
import 'package:condominio/screens/sign_up.dart';
import 'package:condominio/screens/visitantes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Home Screen',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/signup': (context) => const SignUp(),
        '/read_users': (context) => const ReadUsers(),
        '/carros_morador': (context) => const CarrosMoradorScreen(
              id: '6Ox9RRJiSfPgJyqalV2F',
            ),
        '/visitantes': (context) => const VisitantesScreen(
              id: '6Ox9RRJiSfPgJyqalV2F',
        )
      },
    );
  }
}
