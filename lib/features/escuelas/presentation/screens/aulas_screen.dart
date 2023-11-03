import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tfg_app/features/escuelas/domain/domain.dart';
import 'package:tfg_app/features/escuelas/presentation/providers/aulas_provider.dart';
import 'package:tfg_app/features/escuelas/presentation/widgets/widgets.dart';

class AulasScreen extends ConsumerWidget {
  const AulasScreen({super.key, required this.idEscuela});

  final String idEscuela;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final aulaState = ref.watch(aulasProvider(idEscuela));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aulas'),
        centerTitle: true,
      ),
      body: _AulasView(aulas: aulaState.aulas,),
    );
  }
}

class _AulasView extends StatelessWidget {
  const _AulasView({
    required this.aulas,
  });

  final List<Aula> aulas;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MasonryGridView.count(
        itemCount: aulas.length,
        crossAxisCount: 2,
        itemBuilder: (context, index) {
          final aula = aulas[index];
          return GestureDetector(
            child: AulaGridCard(aula: aula),
            onTap: () => print(aula.asientos.length),
          );
        },
      ),
    );
  }
}