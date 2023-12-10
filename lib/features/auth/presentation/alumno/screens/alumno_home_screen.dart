import 'package:flutter/material.dart';
import 'package:tfg_app/features/auth/presentation/alumno/screens/screens.dart';
import 'package:tfg_app/features/reservas/presentation/screens/screens.dart';

class AlumnoHomeScreen extends StatefulWidget {
  const AlumnoHomeScreen({super.key});

  @override
  State<AlumnoHomeScreen> createState() => _AlumnoHomeScreenState();
}

class _AlumnoHomeScreenState extends State<AlumnoHomeScreen> {

  int _currentIndex = 0;
  final viewRoutes = const [EscuelasScreen(), AlumnoProfileScreen()]; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: viewRoutes[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio'
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil'
          ),
          
        ]
      ),
    );
  }
}