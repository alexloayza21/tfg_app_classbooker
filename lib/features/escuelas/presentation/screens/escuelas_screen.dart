import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/escuelas/presentation/providers/escuelas_provider.dart';
import 'package:tfg_app/features/escuelas/presentation/widgets/escuela_card.dart';

class EscuelasScreen extends StatelessWidget {
  const EscuelasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escuelas'),
        centerTitle: true,
      ),
      body: const _EscuelasView(),
    );
  }
}

class _EscuelasView extends ConsumerStatefulWidget {
  const _EscuelasView();

  @override
  _EscuelasViewState createState() => _EscuelasViewState();
}

class _EscuelasViewState extends ConsumerState<_EscuelasView> {

  @override
  Widget build(BuildContext context) {
    
    final escuelasState = ref.watch(escuelasProvider);
    
    return ListView.builder(
      itemCount: escuelasState.escuelas.length,
      itemBuilder: (context, index) {
        final escuela = escuelasState.escuelas[index];
        return Column(
          children: [
            EscuelaCard(escuela: escuela)
          ],
        );


      },
    );
  }
}