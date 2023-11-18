import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';
import 'package:tfg_app/features/reservas/presentation/providers/aulas_provider.dart';
import 'package:tfg_app/features/reservas/presentation/widgets/widgets.dart';

class EscuelaProfileInfo extends ConsumerWidget {
  const EscuelaProfileInfo({super.key, required this.escuela});

  final Escuela escuela;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final aulasState = ref.watch(aulasProvider(escuela.idEscuela!));

    final textStyle = Theme.of(context).textTheme;
    return Expanded(
      child: Column(
        children: [
    
          _EscuelaProfileCard(escuela: escuela, textStyle: textStyle),
    
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                ),
                child: (aulasState.aulas.isNotEmpty) 
                ? MasonryGridView.count(
                  itemCount: aulasState.aulas.length,
                  crossAxisCount: 2, 
                  itemBuilder: (context, index) {
                    final aula = aulasState.aulas[index];
                    return GestureDetector(
                      child: AulaGridCard(aula: aula),
                      onTap: () => context.push('/aula/${aula.idAula}'),
                    );
                  },
                )
                : const Center(
                  child: Text('No tienes aulas 🫠'),
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EscuelaProfileCard extends StatelessWidget {
  const _EscuelaProfileCard({
    required this.escuela,
    required this.textStyle,
  });

  final Escuela escuela;
  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/escuela/${escuela.idEscuela}');
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage (
              colorFilter: const ColorFilter.mode(Colors.black38, BlendMode.hardLight),
              image: NetworkImage(escuela.imagen), 
              fit: BoxFit.cover
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text(escuela.nombreEscuela, style: textStyle.titleLarge, textAlign: TextAlign.center,)),
                const Spacer(),
                const Spacer(),
                Expanded(
                  child: Center(
                    child: Text(
                      '🚩 ${escuela.direccion}, ${escuela.ciudad}, ${escuela.provincia}, ${escuela.codigoPostal} ',
                      textAlign: TextAlign.center,
                      style: textStyle.titleMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}