
import '../../models/alunos_model.dart';
import '../../repositories/alunos/alunos_repository.dart';
import 'alunos_services.dart';

class AlunosServicesImpl implements AlunosServices {
  final AlunosRepository _alunoRepository;

  AlunosServicesImpl({required AlunosRepository alunoRepository})
      : _alunoRepository = alunoRepository;

  @override
  Future<void> save(String nome, String email, String telefone, double valor, String senha) =>
      _alunoRepository.save(nome, email, telefone, valor, senha);

  @override
  Future<void> checkOrUncheckAlunos(AlunosModel aluno) => _alunoRepository.checkOrUncheckAlunos(aluno);
  
  @override
  Future<void> getAllAlunos() => _alunoRepository.getAllAlunos();
  
  @override
  Future<void> deleteAllAlunos() => _alunoRepository.deleteAllAlunos();
  
  @override
  Future<void> deleteById(int id) => _alunoRepository.deleteById(id);
}