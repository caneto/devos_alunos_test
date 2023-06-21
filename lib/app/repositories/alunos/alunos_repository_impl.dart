import '../../core/database/sqlite_connection_fectory.dart';
import '../../models/alunos_model.dart';
import 'alunos_repository.dart';

class AlunosRepositoryImpl implements AlunosRepository {
  final SqliteConnectionFectory _sqliteConnectionFectory;

  AlunosRepositoryImpl(
      {required SqliteConnectionFectory sqliteConnectionFectory})
      : _sqliteConnectionFectory = sqliteConnectionFectory;

  @override
  Future<void> save(String nome, String email, String telefone, double valor, String senha) async {
    final conn = await _sqliteConnectionFectory.openConnection();
    await conn.insert("aluno", {
      'id': null,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'valor': valor,
      'senha': senha,
      'situacao': 0
    });
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
  Future<void> deleteAllAlunos() async {
    final conn = await _sqliteConnectionFectory.openConnection();
    await conn.rawDelete("delete from todo");
  }
  
  @override
  Future<void> deleteById(int id) async {
    final conn = await _sqliteConnectionFectory.openConnection();
    await conn.rawDelete("delete from todo where id = ? ", [id]);
  }
}
