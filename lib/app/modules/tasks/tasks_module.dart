import 'package:devos_alunos_test/app/modules/tasks/task_create_controller.dart';
import 'package:devos_alunos_test/app/modules/tasks/task_create_page.dart';
import 'package:provider/provider.dart';

import '../../core/modules/todo_list_module.dart';
import '../../repositories/tasks/tasks_repository.dart';
import '../../repositories/tasks/tasks_repository_impl.dart';
import '../../services/tasks/tasks_services.dart';
import '../../services/tasks/tasks_services_impl.dart';

class TasksModule extends TodoListModule {
  TasksModule()
      : super(bindings: [
          Provider<TasksRepository>(
            create: (context) => TasksRepositoryImpl(
              sqliteConnectionFectory: context.read(),
            ),
          ),
          Provider<TasksServices>(
            create: (context) => TasksServicesImpl(
              taskRepository: context.read(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) =>
                TaskCreateController(tasksServices: context.read()),
          )
        ], routers: {
          '/task/create': (context) => TaskCreatePage(
                controller: context.read(),
              )
        });
}
