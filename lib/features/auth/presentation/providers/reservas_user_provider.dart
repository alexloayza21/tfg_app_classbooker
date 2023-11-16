import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';
import 'package:tfg_app/features/reservas/domain/repositories/escuelas_repository.dart';
import 'package:tfg_app/features/reservas/presentation/providers/escuelas_repository_provider.dart';

final reservasUserProvider = StateNotifierProvider.autoDispose.family<ReservasUserNotifier, ReservasUserState, String>(
  (ref, id) {
    final escuelasRepository = ref.watch(escuelasRepositoryProvider);
    return ReservasUserNotifier(escuelasRepository: escuelasRepository, id: id);
});

class ReservasUserNotifier extends StateNotifier<ReservasUserState> {
  final EscuelasRepository escuelasRepository;

  ReservasUserNotifier({
    required this.escuelasRepository,
    required String id
  }) : super(ReservasUserState(id: id)){
    loadReservas();
  }

  Future<void> loadReservas() async{
    if ( state.isLoading ) return;
    state = state.copyWith(isLoading: true);

    final reservas = await escuelasRepository.getReservasByUserId(state.id);

    state = state.copyWith(
      isLoading: false,
      reservas: reservas
    );

  }

}

class ReservasUserState {
  final String id;
  final bool isLoading;
  final List<Reserva> reservas;

  ReservasUserState({
    required this.id, 
    this.isLoading = false, 
    this.reservas = const []
  });

  ReservasUserState copyWith({
    String? id,
    bool? isLoading,
    List<Reserva>? reservas,
  }) => ReservasUserState(
    id: id ?? this.id,
    isLoading: isLoading ?? this.isLoading, 
    reservas: reservas ?? this.reservas, 
  );
}