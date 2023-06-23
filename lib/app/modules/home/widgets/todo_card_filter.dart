import 'package:devos_alunos_test/app/core/ui/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/alunos_filter_enum.dart';
import '../../../models/total_alunos_model.dart';
import '../home_controller.dart';

class AlunosCardFilter extends StatelessWidget {
  final String label;
  final AlunosFilterEnum alunosFilter;
  final TotalAlunosModel? totalTasksModel;
  final bool selected;

  const AlunosCardFilter({
    super.key,
    required this.label,
    required this.alunosFilter,
    required this.selected,
    this.totalTasksModel,
  });

  int _getQtyTasks() {
    //final total = totalTasksModel?.totalTasks ?? 0;
    //final totalFinish = totalTasksModel?.totalTasksFinish ?? 0;
    return 0; //total - totalFinish;
  }

 // double _getPercentFinish() {
 //   final total = totalTasksModel?.totalTasks ?? 0.0;
 //   final totalFinish = totalTasksModel?.totalTasksFinish ?? 0.1;

 //   if (total == 0) {
 //     return 0.0;
 //   } else {
 //     return (totalFinish * 100) / total / 100;
 //   }
 //   
 // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<HomeController>().findTasks(filter: alunosFilter),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 120,
          maxWidth: 150,
        ),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: selected ? context.primaryColor : Colors.white,
          border: Border.all(
            width: 1,
            color: Colors.grey.withOpacity(.8),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /* SizedBox(
              height: 21,
              width: 21,
              child: CircularProgressIndicator(),
            ) */
            Text(
              '${_getQtyTasks()} Alunos',
              style: context.titleStyle.copyWith(
                fontSize: 10,
                color: selected ? Colors.white : Colors.grey,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: selected ? Colors.white : Colors.black,
              ),
            ),
            TweenAnimationBuilder<double>(
              tween: Tween(
                begin: 0.0,
                end: 0, //_getPercentFinish(),
              ),
              duration: const Duration(seconds: 1),
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  backgroundColor: selected
                      ? context.primaryColorLight
                      : Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      selected ? Colors.white : context.primaryColor),
                  value: value,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
