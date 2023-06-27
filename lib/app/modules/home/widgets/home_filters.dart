import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/styles/text_styles.dart';
import '../../../models/alunos_filter_enum.dart';
import '../../../models/total_alunos_model.dart';
import '../home_controller.dart';
import 'home_card_filter.dart';

class HomeFilters extends StatelessWidget {
  const HomeFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FILTROS',
          style: TextStyles.i.titleStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              HomeCardFilter(
                label: 'Em Dia',
                alunosFilter: AlunosFilterEnum.emDia,
                totalTasksModel:
                    context.select<HomeController, TotalAlunosModel?>(
                        (controller) => controller.totalAlunosModels),
                selected: context.select<HomeController, AlunosFilterEnum>(
                        (value) => value.filterSelected) ==
                    AlunosFilterEnum.emDia,
              ),
              HomeCardFilter(
                label: 'Atrasado',
                alunosFilter: AlunosFilterEnum.atrasados,
                totalTasksModel:
                    context.select<HomeController, TotalAlunosModel?>(
                        (controller) => controller.totalAlunosAtrasados),
                selected: context.select<HomeController, AlunosFilterEnum>(
                        (value) => value.filterSelected) ==
                    AlunosFilterEnum.atrasados,
              ),
              HomeCardFilter(
                label: 'Cancelados',
                alunosFilter: AlunosFilterEnum.atrasados,
                totalTasksModel:
                    context.select<HomeController, TotalAlunosModel?>(
                        (controller) => controller.totalAlunosAtrasados),
                selected: context.select<HomeController, AlunosFilterEnum>(
                        (value) => value.filterSelected) ==
                    AlunosFilterEnum.cancelados,
              ),
            ],
          ),
        )
      ],
    );
  }
}
