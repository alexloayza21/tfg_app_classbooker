import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tfg_app/config/router/app_router_notifier.dart';
import 'package:tfg_app/features/auth/presentation/admin/screens/escuela_post_screen.dart';
import 'package:tfg_app/features/auth/presentation/admin/screens/screens.dart';
import 'package:tfg_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:tfg_app/features/auth/presentation/alumno/screens/screens.dart';
import 'package:tfg_app/features/reservas/presentation/screens/screens.dart';

final goRouterProvider = Provider((ref) {

  final goRouterNotifier = ref.read(goRouterNotifierProvider);
  return GoRouter(
    initialLocation: '/checkAuth', 
    refreshListenable: goRouterNotifier,
    routes: [

      GoRoute(
        path: '/',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

      GoRoute(
        path: '/checkAuth',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      GoRoute(
        path: '/escuelas',
        builder: (context, state) => const EscuelasScreen(),
        routes: [
          GoRoute(
            path: 'aulas/:idEscuela',
            builder: (context, state) => AulasScreen(idEscuela: state.pathParameters['idEscuela'] ?? '',),
          ),

          GoRoute(
            path: 'reservasForm/:idAula',
            builder: (context, state) => ReservasScreen(idAula: state.pathParameters['idAula'] ?? '',),
          ),
        ]
      ),

      GoRoute(
        path: '/userHome',
        builder: (context, state) => const AlumnoHomeScreen()
      ),



      GoRoute(
        path: '/adminHome',
        builder: (context, state) => const AdminHomeScreen(),
        routes: [
          GoRoute(
            path: 'reservasAdmin',
            builder: (context, state) => const ReservasAdminScreen(),
          ),

          GoRoute(
            path: 'adminProfile',
            builder: (context, state) => const AdminProfileScreen(),
            routes: [
              GoRoute(
                path: 'escuelaUpdate/:idEscuela',
                builder: (context, state) => EscuelaUpdateScreen(escuelaId: state.pathParameters['idEscuela'] ?? ''),
              ),

              GoRoute(
                path: 'escuelaPost/:idEscuela',
                builder: (context, state) => EscuelaPostScreen(escuelaId: state.pathParameters['idEscuela'] ?? ''),
              ),

              GoRoute(
                path: 'aula/:idAula',
                builder: (context, state) => AulaScreen(idAula: state.pathParameters['idAula'] ?? ''),
              ),
            ]
          )
        ]
      ),

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

      if ( authStatus == AuthStatus.authenticated && !isAdmin) {
        if (isGoingTo == '/login' || isGoingTo == '/register' || isGoingTo == '/checkAuth') return '/userHome';
      }

      return null;

    },

  );
});