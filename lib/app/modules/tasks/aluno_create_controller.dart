// ignore_for_file: prefer_final_fields, avoid_print


import '../../core/notifier/default_change_notifier.dart';
import '../../models/alunos_model.dart';
import '../../services/alunos/alunos_services.dart';

class TaskCreateController extends DefaultChangeNotifier {
  AlunosServices _alunosServices;
  DateTime? _selectedDate;
  AlunosModel? aluno;

  TaskCreateController({required AlunosServices alunosServices})
      : _alunosServices = alunosServices;

  set selectedDate(DateTime? selectedDate) {
    resetState();
    _selectedDate = selectedDate;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  Future<void> save(String nome, String email, String telefone, double valor, String senha, String observacao) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      await _alunosServices.save(nome,email,telefone,valor,senha, observacao);
      success();
    }  catch (e, s) {
      print(e);
      print(s);
      setError('Erro ao cadastrar task');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<AlunosModel?> findbyId({required int alunoId}) async {
    showLoading();
    notifyListeners();

    aluno = await _alunosServices.findById(alunoId);    

    //print(aluno);

    hideLoading();
    notifyListeners();

    return aluno;
  }
}
