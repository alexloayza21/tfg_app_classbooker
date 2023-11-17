import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';
import 'package:tfg_app/features/reservas/domain/repositories/reservas_repository.dart';
import 'package:tfg_app/features/reservas/presentation/providers/reservas_repository_provider.dart';

//*provider
final reservaFormProvider = StateNotifierProvider.autoDispose.family<ReservaFormNotifier, ReservaFormState, String>((ref, date) {
  final reservasRepository = ref.watch(reservasRepositoryProvider);
  return ReservaFormNotifier(
    reservasRepository: reservasRepository, 
    date: date
  );
});

//* notifier
class ReservaFormNotifier extends StateNotifier<ReservaFormState> {
  final ReservasRepository reservasRepository;

  ReservaFormNotifier({
    required this.reservasRepository,
    required String date
  }) : super(ReservaFormState(date: date)){
    loadReservasByDate();
  }

  Future<void> loadReservasByDate() async{
    if ( state.isLoading ) return;
    state = state.copyWith(isLoading: true);

    if ( state.date.isEmpty ){
      state = state.copyWith(
        date: DateTime.now().toString().split(' ')[0]
      );
      return;
    }

    final reservas = await reservasRepository.getReservasByDate(state.date);

    state = state.copyWith(
      isLoading: false,
      reservas: reservas
    );
  }

  Future<void> postReserva(Reserva newReserva) async{

    if (state.isLoading) return;
    state = state.copyWith(isLoading: true);

    await reservasRepository.postReserva(newReserva);
    
    state = state.copyWith(
      isLoading: false,
    );

  }

  bool checkHoras(String? horaEntrada, String? horaSalida){
    if (horaEntrada == horaSalida) return true;
    return false;
  }

}

//* state
class ReservaFormState {
  final String date;
  final bool isLoading;
  final List<Reserva> reservas;

  ReservaFormState({
    required this.date, 
    this.isLoading = false, 
    this.reservas = const []
  });

  ReservaFormState copyWith({    
    String? date,
    bool? isLoading,
    List<Reserva>? reservas
  }) => ReservaFormState(
    date: date ?? this.date,
    isLoading: isLoading ?? this.isLoading,
    reservas: reservas ?? this.reservas
  );

}