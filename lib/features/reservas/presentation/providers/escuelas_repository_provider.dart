import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/reservas/domain/repositories/escuelas_repository.dart';
import 'package:tfg_app/features/reservas/infrastructure/datasources/escuelas_datasource_impl.dart';
import 'package:tfg_app/features/reservas/infrastructure/repositories/escuelas_repository_impl.dart';

final escuelasRepositoryProvider = Provider<EscuelasRepository>((ref) {
  String accessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1M2I5MTIxMjI3NTQ5Yjk0ZTcwMTMxMSIsImlhdCI6MTY5OTYxODE4NX0.1L2GtkFSC97qKM11R0SjT1A_tHThi69eADYZg57DUtY';
  final escuelasRepository = EscuelasRepositoryImpl(
    datasource: EscuelasDatasourceImpl(accessToken: accessToken)
  );
  return escuelasRepository;
});