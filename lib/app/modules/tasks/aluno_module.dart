import 'package:devos_alunos_test/app/modules/tasks/aluno_create_controller.dart';
import 'package:devos_alunos_test/app/modules/tasks/aluno_create_page.dart';
import 'package:provider/provider.dart';

import '../../core/modules/todo_list_module.dart';
import '../../repositories/alunos/alunos_repository.dart';
import '../../repositories/alunos/alunos_repository_impl.dart';
import '../../services/alunos/alunos_services.dart';
import '../../services/alunos/alunos_services_impl.dart';

class TasksModule extends TodoListModule {
  TasksModule()
      : super(bindings: [
          Provider<AlunosRepository>(
            create: (context) => AlunosRepositoryImpl(
              sqliteConnectionFectory: context.read(),
            ),
          ),
          Provider<AlunosServices>(
            create: (context) => AlunosServicesImpl(
              alunoRepository: context.read(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) =>
                TaskCreateController(alunosServices: context.read()),
          )
        ], routers: {
          '/task/create': (context) => TaskCreatePage(
                controller: context.read(),
              )
        });
}
