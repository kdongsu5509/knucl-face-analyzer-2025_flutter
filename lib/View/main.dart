import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'home_view.dart';

Future main() async {
  await dotenv.load(fileName: "knuclFaceAnalyzer2025.env");
  runApp(ProviderScope(child: MyApp()),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "ChosunCentennial",
      ),
      debugShowCheckedModeBanner: false,
      title: 'KNUCL FACE Analyzer',
      home: HomeView()
    );
  }
}
