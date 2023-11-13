import 'package:go_router/go_router.dart';
import 'package:tfg_app/features/auth/presentation/admin/screens/screens.dart';
import 'package:tfg_app/features/reservas/presentation/screens/screens.dart';
final appRouter = GoRouter(
  initialLocation: '/CreateUpadteEscuela/new', 
  routes: [

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

    GoRoute(
      path: '/reservasAdmin',
      builder: (context, state) => ReservasAdminScreen(),
    ),

    GoRoute(
      path: '/CreateUpadteEscuela/:idEscuela',
      builder: (context, state) => CreateUpdateEscuelaScreen(escuelaId: state.pathParameters['idEscuela'] ?? ''),
    ),

    GoRoute(
      path: '/newAula/:idAula',
      builder: (context, state) => NewAulaScreen(idAula: state.pathParameters['idAula'] ?? ''),
    )

  ]
);