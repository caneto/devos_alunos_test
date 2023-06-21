import 'package:devos_alunos_test/app/core/ui/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home_controller.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({Key? key}) : super(key: key);

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
          //  Column(
          //    children: context
          //        .select<HomeController, List<AlunosModel>>(
          //            (controller) => controller.filteredAlunos)
          //        .map((t) => Task(model: t,))
          //        .toList(),
          //  ),
        ],
      ),
    );
  }
}
