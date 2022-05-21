import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'view/screens/HomeScreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     title:'Sky News',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
         textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),

      home: HomeScreen(),
    );
  }
}

