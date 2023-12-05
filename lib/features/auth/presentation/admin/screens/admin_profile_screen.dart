import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tfg_app/features/auth/presentation/providers/escuela_admin_provider.dart';
import 'package:tfg_app/features/auth/presentation/providers/providers.dart';
import 'package:tfg_app/features/auth/presentation/widgets/widgets.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';

class AdminProfileScreen extends ConsumerWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final userState = ref.watch(authProvider);
    final textStyle = Theme.of(context).textTheme;

    final escuelaState = ref.watch(escuelaProfileProvider(userState.user!.userId));
    return Scaffold(
      appBar: AppBar(
        title: Text('¡Bienvenido ${userState.user?.username}!'),
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
      body: userState.user?.idEscuela == '' || escuelaState.isLoading
        ? const Center(child: Text('Aun no has registrado una escuela 🫠', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),)
        : _ProfileView(escuela: escuelaState.escuela!),
      floatingActionButton: userState.user?.idEscuela == '' || escuelaState.escuela == null
      ? FloatingActionButton.extended(
        onPressed: () {
          context.push('/adminProfile/escuela/new');
        }, 
        label: const Text('Nueva Escuela'),
        icon: const Icon(Icons.add),
      )
      : FloatingActionButton.extended(
          onPressed: () {
            context.push('/adminProfile/aula/new');
          }, 
          label: const Text('Añadir Aula'),
          icon: const Icon(Icons.add),
        )
    );
  }
}

class _ProfileView extends ConsumerWidget {
  const _ProfileView({required this.escuela});

  final Escuela escuela;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        EscuelaProfileInfo(escuela: escuela,),
      ],
    );
  }
}

class _LogOutDialog extends ConsumerWidget {
  const _LogOutDialog({
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