import 'package:go_router/go_router.dart';
import 'package:tfg_app/features/reservas/presentation/screens/screens.dart';
final appRouter = GoRouter(
  initialLocation: '/', 
  routes: [

    // GoRoute(
    //   path: '/checkStatus'
    // ),

    GoRoute(
      path: '/',
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

  ]
);