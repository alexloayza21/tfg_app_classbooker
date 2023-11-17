import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/auth/presentation/providers/providers.dart';
import 'package:tfg_app/features/reservas/domain/repositories/reservas_repository.dart';
import 'package:tfg_app/features/reservas/infrastructure/datasources/reservas_datasource_impl.dart';
import 'package:tfg_app/features/reservas/infrastructure/repositories/reservas_repository_impl.dart';

final reservasRepositoryProvider = Provider<ReservasRepository>((ref) {
  String accessToken = ref.watch(authProvider).user?.token ?? '';
  final reservasRepository = ReservasRepositoryImpl(
    datasource: ReservasDatasourceImpl(accessToken: accessToken)
  );
  return reservasRepository;
});