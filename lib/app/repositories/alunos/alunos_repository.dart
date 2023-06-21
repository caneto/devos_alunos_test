import '../../models/alunos_model.dart';

abstract class AlunosRepository {
  Future<void> save(String nome, String email, String telefone, double valor, String senha, String observacao);
  Future<List<AlunosModel>> getAllAlunos();
  Future<List<AlunosModel>> findBySituacao(int situacao);
  Future<void> deleteById(int id);
  Future<void> deleteAllAlunos();
  Future<void> checkOrUncheckAlunos(AlunosModel aluno);
}