import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../repositories/tasks/tasks_repository.dart';

class HomeDrawer extends StatelessWidget {
  final nameVN = ValueNotifier<String>('');

  HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            onTap: () {
              context.read<TasksRepository>().deleteAllTasks();
            },
            title: const Text('Sair'),
          ),
        ],
      ),
    );
  }
}
