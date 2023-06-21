// ignore_for_file: prefer_final_fields, avoid_print


import '../../core/notifier/default_change_notifier.dart';
import '../../services/alunos/alunos_services.dart';

class TaskCreateController extends DefaultChangeNotifier {
  AlunosServices _alunosServices;
  DateTime? _selectedDate;

  TaskCreateController({required AlunosServices alunosServices})
      : _alunosServices = alunosServices;

  set selectedDate(DateTime? selectedDate) {
    resetState();
    _selectedDate = selectedDate;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  Future<void> save(String nome, String email, String telefone, double valor, String senha) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      await _alunosServices.save(nome,email,telefone,valor,senha);
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
}
