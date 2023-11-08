import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/reservas/domain/repositories/escuelas_repository.dart';
import 'package:tfg_app/features/reservas/infrastructure/datasources/escuelas_datasource_impl.dart';
import 'package:tfg_app/features/reservas/infrastructure/repositories/escuelas_repository_impl.dart';

final escuelasRepositoryProvider = Provider<EscuelasRepository>((ref) {
  String accessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1M2E0YjVlMzMzOWU1MDdiMjQ3ZTU3ZiIsImlhdCI6MTY5OTQzMDY5M30.xGTmQdoDMQRSMvZPaMxy7dVblWXR6PWczKGJdpBCxR4';
  final escuelasRepository = EscuelasRepositoryImpl(
    datasource: EscuelasDatasourceImpl(accessToken: accessToken)
  );
  return escuelasRepository;
});