import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tfg_app/features/reservas/presentation/providers/escuelas_provider.dart';
import 'package:tfg_app/features/reservas/presentation/widgets/widgets.dart';

class EscuelasScreen extends ConsumerWidget {
  const EscuelasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final escuelasState = ref.watch(escuelasProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escuelas'),
        centerTitle: true,
      ),
      body:  _EscuelasView(escuelasState: escuelasState,),
    );
  }
}

class _EscuelasView extends StatelessWidget {
  const _EscuelasView({required this.escuelasState});

  final EscuelasState escuelasState;

  @override
  Widget build(BuildContext context) {
    
    
    return escuelasState.isLoading 
    ? const Center(child: CircularProgressIndicator()) 
    : ListView.builder(
      itemCount: escuelasState.escuelas.length,
      itemBuilder: (context, index) {
        final escuela = escuelasState.escuelas[index];
        return Column(
          children: [
            GestureDetector(
              child: EscuelaCard(escuela: escuela),
              onTap: () => context.push('/escuelas/aulas/${escuela.idEscuela}'),
            )
          ],
        );


      },
    );
  }
}