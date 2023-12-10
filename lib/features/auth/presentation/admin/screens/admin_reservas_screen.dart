import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:tfg_app/config/config.dart';
import 'package:tfg_app/features/auth/presentation/providers/providers.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';
import 'package:tfg_app/features/reservas/presentation/providers/reservas_provider.dart';
import 'package:tfg_app/features/shared/widgets/widets.dart';

class ReservasAdminScreen extends ConsumerWidget {
  const ReservasAdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final date = DateTime.now().toString().split(' ')[0];

    final authState = ref.watch(authProvider);
    final reservaState = ref.watch(reservasProvider(date));
    late List<Reserva> reservas = reservaState.reservas.where((e) => e.idEscuela == authState.user?.idEscuela).toList();
    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservas de hoy'),
        centerTitle: true,
      ),
      body: (reservaState.isLoading) 
      ? const Center(child: CircularProgressIndicator()) 
      : LiquidPullToRefresh(
        onRefresh: () async{  
          await ref.read(reservasProvider(date).notifier).loadReservasByDate();
        },
        color: AppTheme().colorSeed,
        showChildOpacityTransition: false,
        springAnimationDurationInMilliseconds: 400,
        child: _ReservasAdminView(reservas: reservas,)),
    );
  }
}

class _ReservasAdminView extends ConsumerWidget {
  const _ReservasAdminView({
    required this.reservas,
  });

  final List<Reserva> reservas;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return (reservas.isEmpty)
    ? Center(
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height/3.5),
            child: Column(
              children: [
                Image.asset('assets/lottieFiles/emptyGif.gif'),
                const Text('Hoy no hay reservas'),
              ],
            ),
          )
        ],
      ),
    )
    : ListView.builder(
      itemCount: reservas.length,
      itemBuilder: (context, index) {
        final reserva = reservas[index];
        return ReservasCard(
          id: reserva.id ?? '',
          username: reserva.username,
          nombreAula: reserva.nombreAula,
          asientos: reserva.asientos,
          horaEntrada: reserva.horaEntrada,
          horaSalida: reserva.horaSalida,
          fecha: reserva.fecha,
          onPressed: () {
            ref.read(reservasProvider(DateTime.now().toString().split(' ')[0]).notifier).deleteReserva(reserva.id ?? '');
            Navigator.pop(context);
          },
        );
      },
    );
  }
}