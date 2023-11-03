import 'package:go_router/go_router.dart';
import 'package:tfg_app/features/escuelas/presentation/screens/screens.dart';
final appRouter = GoRouter(
  initialLocation: '/escuelas', 
  routes: [

    // GoRoute(
    //   path: '/checkStatus'
    // ),

    GoRoute(
      path: '/escuelas',
      builder: (context, state) => const EscuelasScreen(),
    ),

  ]
);