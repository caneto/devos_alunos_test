import 'package:devos_alunos_test/app/core/ui/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../../models/alunos_model.dart';
import '../../tasks/aluno_module.dart';
import '../home_controller.dart';

class Aluno extends StatefulWidget {
  final AlunosModel _aluno;

  const Aluno(
      {Key? key,
      required AlunosModel aluno})
      : _aluno = aluno,        
        super(key: key);

  @override
  State<Aluno> createState() => _AlunoState();
}

class _AlunoState extends State<Aluno> {

  Future<void> _goToEditAluno(BuildContext context) async {
    await Navigator.of(context).push(
      //MaterialPageRoute(
      //  builder: (_) => TasksModule().getPage('/task/create', context),
      //),
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation =
              CurvedAnimation(parent: animation, curve: Curves.easeInQuad);
          return ScaleTransition(
            scale: animation,
            alignment: Alignment.bottomRight,
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return AlunoModule().getPage('/task/edit', context);
        },
      ),
    );
    // ignore: use_build_context_synchronously
    context.read<HomeController>().refreshPage();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.5,
        dragDismissible: true,
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            borderRadius: const BorderRadius.only(
              //bottomRight: Radius.circular(30),
              //topRight: Radius.circular(30),
              bottomLeft: Radius.circular(100),
              topLeft: Radius.circular(100),
            ),
            label: "Editar",
            foregroundColor: Colors.white,
            onPressed: (_) =>
                _goToEditAluno(context),
            icon: Icons.edit,
            backgroundColor: Colors.blue,
          ),
          SlidableAction(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20),
              topRight: Radius.circular(20),
              //  bottomLeft: Radius.circular(100),
              //  topLeft: Radius.circular(100),
            ),
            label: "Excluir",
            foregroundColor: Colors.white,
            onPressed: (_) =>
                context.read<HomeController>().deleteTasks(widget._aluno.id),
            icon: Icons.delete,
            backgroundColor: context.deleteColor,
          )
        ],
      ),
      child: Card(
        shadowColor: context.primaryColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: context.primaryColorLight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
              child: Text(
                'Nome: ${widget._aluno.nome}',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 5, right: 5),
              child: Text(
                'Email: ${widget._aluno.email}',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 5, right: 5),
              child: Text(
                'Telefone: ${widget._aluno.telefone}',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 5, right: 5),
              child: Text(
                'Senha: ${widget._aluno.senha}',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Mensalidade: ${widget._aluno.valor.toString()}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        widget._aluno.situacao ? "Inativo" : "Ativo: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              widget._aluno.situacao ? Colors.red : Colors.green,
                        ),
                      ),
                    ),
                    Switch(
                      value: !widget._aluno.situacao,
                      onChanged: (value) => context
                          .read<HomeController>()
                          .checkOrUncheckTask(widget._aluno),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
