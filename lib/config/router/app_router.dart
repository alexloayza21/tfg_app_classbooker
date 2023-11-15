import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tfg_app/config/router/app_router_notifier.dart';
import 'package:tfg_app/features/auth/presentation/admin/screens/screens.dart';
import 'package:tfg_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:tfg_app/features/auth/presentation/user/screens/screens.dart';
import 'package:tfg_app/features/reservas/presentation/screens/screens.dart';

final goRouterProvider = Provider((ref) {

  final goRouterNotifier = ref.read(goRouterNotifierProvider);
  return GoRouter(
    initialLocation: '/checkAuth', 
    refreshListenable: goRouterNotifier,
    routes: [

      GoRoute(
        path: '/checkAuth',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

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

    ],

    redirect: (context, state) {
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;
      final isAdmin = goRouterNotifier.isAdmin;

      if (isGoingTo == '/checkAuth' && authStatus == AuthStatus.checking) return null;

      if ( authStatus == AuthStatus.notAuthenticated) {
        if ( isGoingTo == '/login' || isGoingTo == '/register') return null;
        return '/login';
      }

      if ( authStatus == AuthStatus.authenticated && isAdmin) {
        if (isGoingTo == '/login' || isGoingTo == '/register' || isGoingTo == '/checkAuth') return '/adminHome';
      }

      return null;

    },

  );
});