import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/escuelas/domain/repositories/escuelas_repository.dart';
import 'package:tfg_app/features/escuelas/infrastructure/datasources/escuelas_datasource_impl.dart';
import 'package:tfg_app/features/escuelas/infrastructure/repositories/escuelas_repository_impl.dart';

final escuelasRepositoryProvider = Provider<EscuelasRepository>((ref) {
  String accessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1M2E0YjVlMzMzOWU1MDdiMjQ3ZTU3ZiIsImlhdCI6MTY5ODkyMzMxNn0.v5WKPCx0IB3nsP-ebvqyHs_GRxtuCJuBWcb2YacdUCA';
  final escuelasRepository = EscuelasRepositoryImpl(
    datasource: EscuelasDatasourceImpl(accessToken: accessToken)
  );
  return escuelasRepository;
});