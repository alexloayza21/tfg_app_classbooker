import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';
import 'package:tfg_app/features/reservas/domain/repositories/reservas_repository.dart';
import 'package:tfg_app/features/reservas/presentation/providers/reservas_repository_provider.dart';

//* provider
final reservasProvider = StateNotifierProvider.autoDispose.family<ReservaNotifier, ReservaState, String>( //*qutar el autodispose, por ahora
  (ref, date) {
    final reservasRepository = ref.watch(reservasRepositoryProvider);
    return ReservaNotifier(
      reservasRepository: reservasRepository, 
      date: date
    );
  });

//* notifier
class ReservaNotifier extends StateNotifier<ReservaState> {
  final ReservasRepository reservasRepository;

  ReservaNotifier({
    required this.reservasRepository,
    required String date
  }) : super(ReservaState(date: date)){
    loadReservasByDate();
  }

  Future<void> loadReservasByDate() async{
    try {
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
    } catch (e) {
      throw Exception();
    }
  }

  Future<bool> postReserva(Reserva newReserva) async{

    try {
      
      final reserva = await reservasRepository.postReserva(newReserva);
      final isReservaInList = state.reservas.any((element) => element.id == reserva.id);

      if (!isReservaInList) {
        state = state.copyWith(
          reservas: [...state.reservas, reserva]
        );
        return true;
      }
      return true;

    } catch (e) {
      return false;
    }

  }
  

  bool checkHoras(String? horaEntrada, String? horaSalida){
    if (horaEntrada == horaSalida) return true;
    return false;
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