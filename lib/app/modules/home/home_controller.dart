import '../../core/notifier/default_change_notifier.dart';
import '../../models/task_filter_enum.dart';
import '../../models/alunos_model.dart';
import '../../models/total_alunos_model.dart';
import '../../services/alunos/alunos_services.dart';

class HomeController extends DefaultChangeNotifier {
  final AlunosServices _alunosServices;
  var filterSelected = TaskFilterEnum.today;
  TotalAlunosModel? totalAlunosModels;
  TotalAlunosModel? totalAlunosAtrasados;
  List<AlunosModel> allAlunos = [];
  List<AlunosModel> filteredTasks = [];
  bool showSituacaoAluno = false;

  HomeController({required AlunosServices alunosServices})
      : _alunosServices = alunosServices;

  Future<void> loadTotalTasks() async {
    _alunosServices.getAllAlunos();

    totalAlunosModels = TotalAlunosModel(
      totalAlunos: allAlunos.length,
      totalAlunosSituacao: allAlunos.where((aluno) => aluno.situacao).length,
    );

    totalAlunosAtrasados = TotalAlunosModel(
      totalAlunos: allAlunos.length,
      totalAlunosSituacao: allAlunos.where((aluno) => aluno.situacao).length,
    );

    notifyListeners();
  }

  Future<void> findTasks({required TaskFilterEnum filter}) async {
    filterSelected = filter;
    showLoading();
    notifyListeners();
    List<AlunosModel> alunos;

    //switch(filter) {
    //case TaskFilterEnum.today:
    alunos = await _alunosServices.getAllAlunos();
    //  break;
    //case TaskFilterEnum.tomorrow:
    //  tasks = await _tasksServices.getTomorrow();
    //  break;
    // case TaskFilterEnum.week:
    //   final weekModel = await _tasksServices.getWeek();
    //   initialDateOfWeek = weekModel.startDate;
    //   tasks = weekModel.tasks;
    //   break;
    //}
    //filteredTasks = tasks;
    allAlunos = alunos;

    if (!showSituacaoAluno) {
      filteredTasks = filteredTasks.where((task) => !task.situacao).toList();
    }

    hideLoading();
    notifyListeners();
  }

  Future<void> refreshPage() async {
    await findTasks(filter: filterSelected);
    await loadTotalTasks();
    notifyListeners();
  }

  Future<void> checkOrUncheckTask(AlunosModel alunos) async {
    showLoadingAndResetState();
    notifyListeners();

    final alunoUpdate = alunos.copyWith(situacao: !alunos.situacao);
    await _alunosServices.checkOrUncheckAlunos(alunoUpdate);
    hideLoading();
    refreshPage();
  }

  void showOrHideFinishTask() {
    showSituacaoAluno = !showSituacaoAluno;
    refreshPage();
    notifyListeners();
  }

  Future<void> deleteTasks(int id) async {
    await _alunosServices.deleteById(id);
    refreshPage();
    notifyListeners();
  }

  Future<void> showOnlyFinishTask() async {
    filteredTasks = allAlunos.where((task) {
      return !task.situacao;
    }).toList();
    notifyListeners();
  }
}
