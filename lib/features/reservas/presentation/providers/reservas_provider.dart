import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';
import 'package:tfg_app/features/reservas/domain/repositories/escuelas_repository.dart';
import 'package:tfg_app/features/reservas/presentation/providers/escuelas_repository_provider.dart';

//* provider
final reservaProvider = StateNotifierProvider.autoDispose.family<ReservaNotifier, ReservaState, String>(
  (ref, date) {
    final escuelasRepository = ref.watch(escuelasRepositoryProvider);
    return ReservaNotifier(
      escuelasRepository: escuelasRepository, 
      date: date
    );
  });

//* notifier
class ReservaNotifier extends StateNotifier<ReservaState> {
  final EscuelasRepository escuelasRepository;

  ReservaNotifier({
    required this.escuelasRepository,
    required String date
  }) : super(ReservaState(date: date)){
    loadReservasByDate();
  }

  Future<void> loadReservasByDate() async{
    if ( state.isLoading ) return;
    state = state.copyWith(isLoading: true);

    if ( state.date.isEmpty ){
      state = state.copyWith(
        date: DateTime.now().toString().split(' ')[0]
      );
    }

    final reservas = await escuelasRepository.getReservasByDate(state.date);

    state = state.copyWith(
      isLoading: false,
      reservas: reservas
    );
  }
}

//* state 
class ReservaState {
  final String date;
  final bool isLoading;
  final List<Reserva> reservas;

  ReservaState({
    required this.date, 
    this.isLoading = false, 
    this.reservas = const []
  });

  ReservaState copyWith({    
    String? date,
    bool? isLoading,
    List<Reserva>? reservas
  }) => ReservaState(
    date: date ?? this.date,
    isLoading: isLoading ?? this.isLoading,
    reservas: reservas ?? this.reservas
  );

}