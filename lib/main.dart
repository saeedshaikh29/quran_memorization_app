import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'features/reader/presentation/pages/home_page.dart';
import 'models/notes_model.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(NoteModelAdapter());

  await Hive.openBox<NoteModel>('notesBox');

  runApp(const QuranMemorizationApp());
}

class QuranMemorizationApp extends StatelessWidget {
  const QuranMemorizationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quran Memorization App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F5EE),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1B4332),
          foregroundColor: Colors.white,
        ),
        useMaterial3: true,
      ),
        home: const HomePage(),
    );
  }
}