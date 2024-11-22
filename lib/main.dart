import 'package:crud_perpustakaan/home_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //WidgetsFlutterBinding digunakan untuk menjalankan aplikasi Flutter
  await Supabase.initialize(
    url: 'https://uwvmbzwwohnepzwdmxcm.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV3dm1iend3b2huZXB6d2RteGNtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE3MjY2NzIsImV4cCI6MjA0NzMwMjY3Mn0.0smct755oTUt8sr92LDY-V94amfUH728MDmTzbTKgko',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Perpustakaan',
      home: BookListPage(),
      debugShowCheckedModeBanner: false,
      );
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
  }
}

