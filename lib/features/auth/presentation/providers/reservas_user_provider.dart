import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';
import 'package:tfg_app/features/reservas/domain/repositories/reservas_repository.dart';
import 'package:tfg_app/features/reservas/presentation/providers/reservas_repository_provider.dart';

final reservasUserProvider = StateNotifierProvider.autoDispose.family<ReservasUserNotifier, ReservasUserState, String>(
  (ref, id) {
    final reservasRepository = ref.watch(reservasRepositoryProvider);
    return ReservasUserNotifier(reservasRepository: reservasRepository, id: id);
});

class ReservasUserNotifier extends StateNotifier<ReservasUserState> {
  final ReservasRepository reservasRepository;

  ReservasUserNotifier({
    required this.reservasRepository,
    required String id
  }) : super(ReservasUserState(id: id)){
    loadReservas();
  }

  Future<void> loadReservas() async{
    try {
      if (mounted) state = state.copyWith(isLoading: true);
      state = state.copyWith(isLoading: true);
  
      final reservas = await reservasRepository.getReservasByUserId(state.id);
  
      state = state.copyWith(
        isLoading: false,
        reservas: reservas
      );
      
    } catch (e) {
      if (mounted) {
        throw Exception(e);
      }
    }

  }

  Future<bool> deleteReserva(String id) async{
    try {
      if (mounted) state = state.copyWith(isLoading: true);
      state = state.copyWith(isLoading: true);

      final reserva = await reservasRepository.deleteReserva(id);

      state = state.copyWith(
        isLoading: false,
        reservas: [...state.reservas.where((element) => element.id != reserva.id)]
      );
      return true;
      
    } catch (e) {
      if (mounted) {
        return false;
      }
      return false;
    }
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