import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/code_editor_screen.dart';
import 'screens/learn_screen.dart';
import 'screens/founders_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Code Editor',
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF2D2D2D),
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF2D2D2D),
          elevation: 0,
          titleTextStyle: GoogleFonts.firaCode(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    CodeEditorScreen(),
    LearnScreen(),
    FoundersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: const Color(0xFF2D2D2D),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.code),
            label: 'Editor',
          ),
          NavigationDestination(
            icon: Icon(Icons.school),
            label: 'Learn',
          ),
          NavigationDestination(
            icon: Icon(Icons.people),
            label: 'Founders',
          ),
        ],
      ),
    );
  }
}
