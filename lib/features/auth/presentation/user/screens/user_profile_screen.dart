import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tfg_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:tfg_app/features/auth/presentation/providers/reservas_user_provider.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final userState = ref.watch(authProvider);
    final reservasState = ref.watch(reservasUserProvider(userState.user!.userId));
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido ${userState.user!.username}'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            showDialog(
              context: context, 
              builder: (context) {
                return _LogOutDialog(textStyle: textStyle);
              },
            );
          }, icon: const Icon(Icons.exit_to_app, color: Colors.black,))
        ],
      ),
      body: _UserProfileView(reservas: reservasState.reservas,),
    );
  }
}

class _UserProfileView extends StatelessWidget {
  const _UserProfileView({
    required this.reservas,
  });

  final List<Reserva> reservas;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class _LogOutDialog extends ConsumerWidget {
  const _LogOutDialog({
    super.key,
    required this.textStyle,
  });

  final TextTheme textStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text('¿Estas seguro que quieres cerrar sesión?', style: textStyle.bodyLarge, textAlign: TextAlign.center,),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: Text('Cancelar', style: GoogleFonts.montserratAlternates()
              .copyWith( color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold ),)
            ),

            TextButton(
              onPressed: () {
                ref.read(authProvider.notifier).logout();
              }, 
              child: Text('Salir', style: GoogleFonts.montserratAlternates()
              .copyWith( color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold ),)
            ),

          ],
        )
      ],
    );
  }
}