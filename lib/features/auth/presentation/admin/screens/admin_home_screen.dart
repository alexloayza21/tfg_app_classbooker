import 'package:flutter/material.dart';
import 'package:tfg_app/features/auth/presentation/admin/screens/screens.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {

  int _currentIndex = 0;
  final viewRoutes = const [ReservasAdminScreen(), AdminProfileScreen()];

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