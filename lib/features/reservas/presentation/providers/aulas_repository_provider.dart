import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/auth/presentation/providers/providers.dart';
import 'package:tfg_app/features/reservas/domain/repositories/aulas_repository.dart';
import 'package:tfg_app/features/reservas/infrastructure/datasources/aulas_datasource_impl.dart';
import 'package:tfg_app/features/reservas/infrastructure/repositories/aulas_repository_impl.dart';

final aulasRepositoryProvider = Provider<AulasRepository>((ref) {
  String accessToken = ref.watch(authProvider).user?.token ?? '';
  final aulasRepository = AulasRepositoryImpl(
    datasource: AulasDatasourceImpl(accessToken: accessToken)
  );
  return aulasRepository;
});