import 'dart:async';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:devos_alunos_test/app/core/ui/helpers/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/ui/styles/text_styles.dart';
import '../../../models/alunos_model.dart';
import '../../alunos/aluno_module.dart';
import '../home_controller.dart';

class HomeCardAluno extends StatefulWidget {
  final AlunosModel _aluno;

  const HomeCardAluno({
    Key? key,
    required AlunosModel aluno,
  })  : _aluno = aluno,
        super(key: key);

  @override
  State<HomeCardAluno> createState() => _HomeCardAlunoState();
}

class _HomeCardAlunoState extends State<HomeCardAluno> {
  
  Future<int?> _showConfirmProductDialog(AlunosModel aluno) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Deseja excluir o aluno ${aluno.nome}?'),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text(
                'Cancelar',
                style: TextStyles.i.textBold.copyWith(
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                context.pop(aluno.id);
              },
              child: const Text(
                'Confirmar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> _goToEditAluno(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();
    sp.setInt('alunoId', widget._aluno.id);

    // ignore: use_build_context_synchronously
    await Navigator.of(context).push(
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
        extentRatio: 0.6,
        dragDismissible: true,
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(100),
              topLeft: Radius.circular(100),
            ),
            label: "Editar",
            foregroundColor: Colors.yellowAccent,
            onPressed: (_) => _goToEditAluno(context),
            icon: Icons.edit,
            backgroundColor: context.primaryColor,
          ),
          SlidableAction(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            label: "Excluir",
            foregroundColor: Colors.white,
            onPressed: (_) async {
              final idAluno = await _showConfirmProductDialog(widget._aluno);
              // ignore: unrelated_type_equality_checks
              if(idAluno != null) {
                // ignore: use_build_context_synchronously
                context.read<HomeController>().deleteTasks(widget._aluno.id); 
              }
            },
            icon: Icons.delete,
            backgroundColor: context.indicatorColor,
          )
        ],
      ),
      child: Column(
        children: [
          Card(
            shadowColor: context.primaryColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: context.primaryColorLight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
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
                      'Senha: ${widget._aluno.senha.trim()}',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 5, right: 5),
                    child: Text(
                      'Observação: ${widget._aluno.observacao.trim()}',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Mensalidade: ${UtilBrasilFields.obterReal(widget._aluno.valor)}',
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
                                color: widget._aluno.situacao
                                    ? Colors.red
                                    : Colors.green,
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
          ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
