import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:technical_test/config/app_theme.dart';
import 'package:technical_test/presentation/providers/book_provider.dart';
import 'package:technical_test/presentation/providers/search_provider.dart';
import 'package:technical_test/presentation/providers/user_provider.dart';
import 'package:technical_test/presentation/screens/detail_screen.dart';
import 'package:technical_test/presentation/screens/detail_user.dart';
import 'package:technical_test/presentation/screens/home_screen.dart';
import 'package:technical_test/presentation/screens/form_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FieldProvider(text: '')),
        ChangeNotifierProvider(create: (_) => BookProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider())
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerDelegate: _router.routerDelegate,
        routeInformationParser: _router.routeInformationParser,
        routeInformationProvider: _router.routeInformationProvider,
        theme: AppTheme(selectedColor: 2).theme(),
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/form',
          builder: (context, state) => const UserFormScreen(),
        ),
        GoRoute(
          path: '/user',
          builder: (context, state) => const UserDetailsPage(),
        ),
        GoRoute(
          path: '/home/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;

            return DetailScreen(
              id: id,
            );
          },
        ),
      ],
    ),
  ],
);

class MainScreen extends StatefulWidget {
  final Widget child;

  const MainScreen({required this.child, super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          context.go('/');
          break;
        case 1:
          context.go('/form');
          break;

        case 2:
          context.go('/user');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.transparent,
          elevation: 0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined),
              label: 'Libros',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.format_align_justify),
              label: 'Formulario',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: 'Usuario',
            ),
          ],
        ),
      ),
    );
  }
}
