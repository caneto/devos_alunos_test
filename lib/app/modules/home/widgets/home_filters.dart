import 'package:devos_alunos_test/app/core/ui/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/task_filter_enum.dart';
import '../../../models/total_tasks_model.dart';
import '../home_controller.dart';
import 'todo_card_filter.dart';

class HomeFilters extends StatelessWidget {
  const HomeFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FILTROS',
          style: context.titleStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TodoCardFilter(
                label: 'HOJE',
                taskFilter: TaskFilterEnum.today,
                totalTasksModel:
                    context.select<HomeController, TotalTasksModel?>(
                        (controller) => controller.todayTotalTasks),
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.filterSelected) ==
                    TaskFilterEnum.today,
              ),
              TodoCardFilter(
                label: 'AMANHÃ',
                taskFilter: TaskFilterEnum.tomorrow,
                totalTasksModel:
                    context.select<HomeController, TotalTasksModel?>(
                        (controller) => controller.tomorrowTotalTasks),
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.filterSelected) ==
                    TaskFilterEnum.tomorrow,
              ),
              TodoCardFilter(
                label: 'SEMANA',
                taskFilter: TaskFilterEnum.week,
                totalTasksModel:
                    context.select<HomeController, TotalTasksModel?>(
                        (controller) => controller.weekTotalTasks),
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.filterSelected) ==
                    TaskFilterEnum.week,
              ),
            ],
          ),
        )
      ],
    );
  }
}