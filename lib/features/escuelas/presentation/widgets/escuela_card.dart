import 'package:flutter/material.dart';
import 'package:tfg_app/features/escuelas/domain/domain.dart';

class EscuelaCard extends StatelessWidget {
  const EscuelaCard({super.key, required this.escuela});

  final Escuela escuela;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _EscuelaCardView(escuela: escuela),
    );
  }
}

class _EscuelaCardView extends StatelessWidget {
  const _EscuelaCardView({
    required this.escuela,
  });

  final Escuela escuela;

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme;

    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          colorFilter: const ColorFilter.mode(Colors.black45, BlendMode.hardLight),
          fit: BoxFit.cover,
          image: NetworkImage(escuela.imagen)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(7,7)
            )
          ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              escuela.nombreEscuela,
              style: textStyle.titleLarge,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),

            const Spacer(flex: 6,),

            Text(
              '${escuela.aulas.length} Aulas',
              style: textStyle.titleMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),

            const Spacer(),

            Row(
              children: [
                const Icon(Icons.location_on_outlined, color: Colors.white, size: 15,),
                Text(
                  '${escuela.direccion}, ${escuela.ciudad}, ${escuela.provincia}, ${escuela.codigoPostal} ',
                  style: textStyle.titleSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}