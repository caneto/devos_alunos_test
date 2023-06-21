import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../repositories/alunos/alunos_repository.dart';

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
              context.read<AlunosRepository>().deleteAllAlunos();
            },
            title: const Text('Sair'),
          ),
        ],
      ),
    );
  }
}
