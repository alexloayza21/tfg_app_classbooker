import 'package:tfg_app/features/escuelas/domain/domain.dart';

abstract class EscuelasDatasource {
  Future<List<Escuela>> getAllEscuelas();
  Future<List<Aula>> getAulasByIdEscuela(String idEscuela);
}