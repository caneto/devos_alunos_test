import 'package:devos_alunos_test/app/core/ui/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/alunos_model.dart';
import '../home_controller.dart';
import 'aluno.dart';

class HomeAluno extends StatelessWidget {
  const HomeAluno({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'Alunos',
            style: context.titleStyle,
          ),
          Column(
              children: context
                  .select<HomeController, List<AlunosModel>>(
                      (controller) => controller.allAlunos)
                  .map((t) => Aluno(aluno: t,))
                  .toList(),
          ),
        ],
      ),
    );
  }
}
