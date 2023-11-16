import 'package:flutter/material.dart';
import 'package:tfg_app/features/auth/presentation/user/screens/screens.dart';
import 'package:tfg_app/features/reservas/presentation/screens/screens.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {

  int _currentIndex = 0;
  final viewRoutes = const [EscuelasScreen(), UserProfileScreen()]; 

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