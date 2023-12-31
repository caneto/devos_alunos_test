import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/alunos_model.dart';
import '../home_controller.dart';
import 'home_card_aluno.dart';

class HomeAluno extends StatefulWidget {
  const HomeAluno({Key? key}) : super(key: key);

  @override
  State<HomeAluno> createState() => _HomeAlunoState();
}

class _HomeAlunoState extends State<HomeAluno> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Column(
            children: context
                .select<HomeController, List<AlunosModel>>(
                    (controller) => controller.allAlunos)
                .map((t) => HomeCardAluno(
                      aluno: t,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
