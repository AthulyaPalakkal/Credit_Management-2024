import 'package:credit_management/home_screen.dart';
import 'package:credit_management/login_page.dart';
import 'package:credit_management/provider/login_provider.dart';
import 'package:credit_management/provider/main_provider.dart';
import 'package:credit_management/sample.dart';
import 'package:credit_management/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainProvider(),),
        ChangeNotifierProvider(create: (context) => LoginProvider(),),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Clear Credit',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Splash(),
      ),
    );
  }
}

