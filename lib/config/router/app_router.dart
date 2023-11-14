import 'package:go_router/go_router.dart';
import 'package:tfg_app/features/auth/presentation/admin/screens/screens.dart';
import 'package:tfg_app/features/auth/presentation/user/screens/screens.dart';
import 'package:tfg_app/features/reservas/presentation/screens/screens.dart';
final appRouter = GoRouter(
  initialLocation: '/register', 
  routes: [

    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),

    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(),
    ),

    GoRoute(
      path: '/escuelas',
      builder: (context, state) => const EscuelasScreen(),
    ),

    GoRoute(
      path: '/aulas/:idEscuela',
      builder: (context, state) => AulasScreen(idEscuela: state.pathParameters['idEscuela'] ?? '',),
    ),

    GoRoute(
      path: '/reservasForm/:idAula',
      builder: (context, state) => ReservasScreen(idAula: state.pathParameters['idAula'] ?? '',),
    ),



    GoRoute(
      path: '/adminHome',
      builder: (context, state) => AdminHomeScreen()
    ),

    GoRoute(
      path: '/reservasAdmin',
      builder: (context, state) => ReservasAdminScreen(),
    ),

    GoRoute(
      path: '/escuela/:idEscuela',
      builder: (context, state) => EscuelaScreen(escuelaId: state.pathParameters['idEscuela'] ?? ''),
    ),

    GoRoute(
      path: '/aula/:idAula',
      builder: (context, state) => AulaScreen(idAula: state.pathParameters['idAula'] ?? ''),
    ),

    GoRoute(
      path: '/adminProfile',
      builder: (context, state) => AdminProfileScreen(),
    )

  ]
);