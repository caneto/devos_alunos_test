
import '../../models/alunos_model.dart';
import '../../models/week_task_model.dart';

abstract class TasksServices {
  Future<void> save(DateTime date, String description);
  Future<void> deleteById(int id);
  Future<void> deleteAllTasks();

  Future<List<TaskModel>> getToday();
  Future<List<TaskModel>> getTomorrow();
  Future<WeekTaskModel> getWeek();
  Future<void> checkOrUncheckTask(TaskModel task);
}