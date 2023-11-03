import 'package:tfg_app/features/escuelas/domain/domain.dart';

abstract class EscuelasRepository {
  Future<List<Escuela>> getAllEscuelas();
}