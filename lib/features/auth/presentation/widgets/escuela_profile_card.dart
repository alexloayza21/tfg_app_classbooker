import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';
import 'package:tfg_app/features/reservas/presentation/widgets/widgets.dart';

class EscuelaProfileCard extends ConsumerWidget {
  const EscuelaProfileCard({super.key, required this.escuela});

  final Escuela escuela;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;
    return Expanded(
      child: Column(
        children: [
    
          _EscuelaInfo(escuela: escuela, textStyle: textStyle),
    
          Expanded(
            child: Container(
              color: Colors.red,
              width: double.infinity,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: (escuela.aulas!.isNotEmpty) ? MasonryGridView.count(
                itemCount: escuela.aulas?.length,
                crossAxisCount: 2, 
                itemBuilder: (context, index) {
                  return AulaGridCard(aula: escuela.aulas![index]);
                },
              )
              : Center(
                child: Text('No tienes aulas'),
              )
            ),
          ),
        ],
      ),
    );
  }
}

class _EscuelaInfo extends StatelessWidget {
  const _EscuelaInfo({
    super.key,
    required this.escuela,
    required this.textStyle,
  });

  final Escuela escuela;
  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
        // print('object');
        // return ref.refresh(authProvider); //* boton para refrescar el 
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
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text(escuela.nombreEscuela, style: textStyle.titleLarge, textAlign: TextAlign.center,)),
                const Spacer(),
                const Spacer(),
                Expanded(
                  child: Text(
                    '🚩 ${escuela.direccion}, ${escuela.ciudad}, ${escuela.provincia}, ${escuela.codigoPostal} ',
                    textAlign: TextAlign.center,
                    style: textStyle.titleMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
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