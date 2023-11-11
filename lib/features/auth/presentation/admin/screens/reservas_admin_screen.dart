import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';
import 'package:tfg_app/features/reservas/presentation/providers/reservas_provider.dart';
import 'package:tfg_app/features/shared/widgets/widets.dart';

class ReservasAdminScreen extends ConsumerWidget {
  const ReservasAdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final reservaState = ref.watch(reservaProvider(DateTime.now().toString().split(' ')[0]));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservas de hoy'),
        centerTitle: true,
      ),
      body: _ReservasAdminView(reservas: reservaState.reservas,),
    );
  }
}

class _ReservasAdminView extends StatelessWidget {
  const _ReservasAdminView({
    required this.reservas,
  });

  final List<Reserva> reservas;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reservas.length,
      itemBuilder: (context, index) {
        return ReservasCard(reserva: reservas[index]);
      },
    );
  }
}