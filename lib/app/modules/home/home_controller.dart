
import '../../core/notifier/default_change_notifier.dart';
import '../../models/task_filter_enum.dart';
import '../../models/alunos_model.dart';
import '../../models/total_tasks_model.dart';
import '../../services/alunos/alunos_services.dart';

class HomeController extends DefaultChangeNotifier {
  final AlunosServices _alunosServices;
  var filterSelected = TaskFilterEnum.today;
  TotalTasksModel? todayTotalTasks;
  TotalTasksModel? tomorrowTotalTasks;
  TotalTasksModel? weekTotalTasks;
  List<AlunosModel> allTasks = [];
  List<AlunosModel> filteredTasks = [];
  DateTime? initialDateOfWeek;
  DateTime? selectedDay;
  bool showFinishingTasks = false;

  HomeController({required AlunosServices alunosServices})
      : _alunosServices = alunosServices;

  Future<void> loadTotalTasks() async {
    _alunosServices.getAllAlunos();
    notifyListeners();
  }

  Future<void> findTasks({required TaskFilterEnum filter}) async {
    filterSelected = filter;
    showLoading();
    notifyListeners();
    List<AlunosModel> alunos;

    //switch(filter) {
      //case TaskFilterEnum.today:
      //  tasks = await _tasksServices.getToday();
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
    //allTasks = tasks;

    if(!showFinishingTasks) {
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

    final alunoUpdate = alunos.copyWith(
      situacao: !alunos.situacao
    );
    await _alunosServices.checkOrUncheckAlunos(alunoUpdate);
    hideLoading();
    refreshPage();
  }

   void showOrHideFinishTask() {
    showFinishingTasks = !showFinishingTasks;
    refreshPage();
    notifyListeners();
  }

  Future<void> deleteTasks(int id) async {
    await _alunosServices.deleteById(id);
    refreshPage();
    notifyListeners();
  }

  Future<void> showOnlyFinishTask() async {
    filteredTasks = allTasks.where((task) {
      return task.situacao;
    }).toList();
    notifyListeners();
  }

}
