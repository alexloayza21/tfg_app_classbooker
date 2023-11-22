import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tfg_app/features/auth/presentation/providers/providers.dart';
import 'package:tfg_app/features/auth/presentation/widgets/widgets.dart';

class AdminProfileScreen extends ConsumerWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final userState = ref.watch(authProvider);
    final textStyle = Theme.of(context).textTheme;

    final escuelaState = ref.watch(escuelaProvider(userState.user!.idEscuela));

    return userState.user?.idEscuela == '' || escuelaState.escuela == null
    ? Scaffold(
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
      body: const Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(child: Text('Aun no has registrado una escuela 🫠', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),),),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push('/escuela/new');
        }, 
        label: const Text('Nueva Escuela'),
        icon: const Icon(Icons.add),
      ),
    ) 
    : Scaffold(
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
      body: _ProfileView(userState: userState,),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.push('/aula/new');
          }, 
          label: const Text('Añadir Aula'),
          icon: const Icon(Icons.add),
        )
    );
  }
}

class _ProfileView extends ConsumerWidget {
  const _ProfileView({
    required this.userState,
  });

  final AuthState userState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final escuelaState = ref.watch(escuelaProvider(userState.user!.idEscuela));
    return escuelaState.isLoading 
    ? const Center(child: CircularProgressIndicator()) 
    : Column(
      children: [
        EscuelaProfileInfo(escuela: escuelaState.escuela!,),
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