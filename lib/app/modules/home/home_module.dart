import 'package:provider/provider.dart';

import '../../core/modules/aluno_list_module.dart';
import '../../repositories/alunos/alunos_repository.dart';
import '../../repositories/alunos/alunos_repository_impl.dart';
import '../../services/alunos/alunos_services.dart';
import '../../services/alunos/alunos_services_impl.dart';
import 'home_controller.dart';
import 'home_page.dart';

class HomeModule extends AlunoListModule {
  HomeModule()
      : super(
            bindings: [
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
                    HomeController(alunosServices: context.read()),
              ),
            ],
            routers: {
              '/home': (context) => HomePage(
                    homeController: context.read(),
                  ),
            });
}
