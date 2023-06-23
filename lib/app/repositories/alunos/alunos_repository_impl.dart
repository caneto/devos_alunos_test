import '../../core/database/sqlite_connection_fectory.dart';
import '../../models/alunos_model.dart';
import 'alunos_repository.dart';

class AlunosRepositoryImpl implements AlunosRepository {
  final SqliteConnectionFectory _sqliteConnectionFectory;

  AlunosRepositoryImpl(
      {required SqliteConnectionFectory sqliteConnectionFectory})
      : _sqliteConnectionFectory = sqliteConnectionFectory;

  @override
  Future<void> save(String nome, String email, String telefone, double valor, String senha, String observacao) async {
    final conn = await _sqliteConnectionFectory.openConnection();
    await conn.insert("aluno", {
      'id': null,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'valor': valor,
      'senha': senha,
      'observacao': observacao,
      'situacao': 0
    });
  }

  @override
  Future<void> edit(int alunoId, String nome, String email, String telefone, double valor, String senha, String observacao) async {
    final conn = await _sqliteConnectionFectory.openConnection();
    await conn.rawUpdate(
      'update aluno set nome = ?, email = ?, telefone = ?, valor = ?, senha = ?, observacao = ? where id = ?', [nome, email, telefone, valor, senha, observacao, alunoId]);
  }

  @override
  Future<void> checkOrUncheckAlunos(AlunosModel aluno) async {
    final conn = await _sqliteConnectionFectory.openConnection();
    final situacao = aluno.situacao ? 1 : 0;

    await conn.rawUpdate(
        'update aluno set situacao = ? where id = ?', [situacao, aluno.id]);
  }

  @override
  Future<List<AlunosModel>> getAllAlunos() async {
    
    final conn = await _sqliteConnectionFectory.openConnection();
    final result = await conn.rawQuery('''
      select *
      from aluno
      order by nome
    ''');
    return result.map((e) => AlunosModel.loadFromDB(e)).toList();
  }

  @override
  Future<List<AlunosModel>> findBySituacao(int situacao) async {
    final conn = await _sqliteConnectionFectory.openConnection();
    final result = await conn.rawQuery('''
      select *
      from aluno
      where situacao = ?
      order by name
    ''', [
      situacao,
    ]);
    return result.map((e) => AlunosModel.loadFromDB(e)).toList();
  }
  
  @override
  Future<void> deleteAllAlunos() async {
    final conn = await _sqliteConnectionFectory.openConnection();
    await conn.rawDelete("delete from aluno");
  }
  
  @override
  Future<void> deleteById(int id) async {
    final conn = await _sqliteConnectionFectory.openConnection();
    await conn.rawDelete("delete from aluno where id = ? ", [id]);
  }
  
  @override
  Future<AlunosModel> findById(int alunoId) async {
    final conn = await _sqliteConnectionFectory.openConnection();
    final result = await conn.rawQuery('''
      select *
      from aluno
      where id = ?
    ''', [
      alunoId,
    ]);
    return AlunosModel.loadFromDB(result.first);
  }
}
