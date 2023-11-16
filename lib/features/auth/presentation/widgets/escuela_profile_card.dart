import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';

class EscuelaProfileCard extends ConsumerWidget {
  const EscuelaProfileCard({super.key, required this.escuela});

  final Escuela escuela;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        
        print('object');
        return ref.refresh(authProvider); //* boton para refrescar el 
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 500,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(30)
          ),
        ),
      ),
    );
  }
}