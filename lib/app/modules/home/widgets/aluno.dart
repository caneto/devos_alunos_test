import 'package:devos_alunos_test/app/core/ui/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../../models/alunos_model.dart';
import '../home_controller.dart';

class Aluno extends StatelessWidget {
  final AlunosModel aluno;

  const Aluno({Key? key, required this.aluno}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.3,
        dragDismissible: true,
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(100),
                topLeft: Radius.circular(100)),
            label: "Excluir",
            foregroundColor: Colors.white,
            onPressed: (_) =>
                context.read<HomeController>().deleteTasks(aluno.id),
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
                'Nome: ${aluno.nome}',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 5, right: 5),
              child: Text(
                'Email: ${aluno.email}',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 5, right: 5),
              child: Text(
                'Telefone: ${aluno.telefone}',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 5, right: 5),
              child: Text(
                'Senha: ${aluno.senha}',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Mensalidade: ${aluno.valor.toString()}',
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
                        aluno.situacao ? "Inativo" : "Ativo: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: aluno.situacao ? Colors.red : Colors.green,
                        ),
                      ),
                    ),
                    Switch(
                      value: !aluno.situacao,
                      onChanged: (value) => context
                          .read<HomeController>()
                          .checkOrUncheckTask(aluno),
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
