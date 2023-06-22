import 'dart:async';

import 'package:devos_alunos_test/app/core/ui/theme_extensions.dart';
import 'package:flutter/material.dart';

import '../navigator/alunos_list_navigator.dart';

class TodoListLogo extends StatefulWidget {
  const TodoListLogo({Key? key}) : super(key: key);

  @override
  State<TodoListLogo> createState() => _TodoListLogoState();
}

class _TodoListLogoState extends State<TodoListLogo> {

  _TodoListLogoState() {
    Timer(const Duration(milliseconds: 900), () {
      setState(() {
        AlunosListNavigator.to
              .pushNamedAndRemoveUntil('/home', (route) => false);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logo.png',
          height: 200,
        ),
        Text('Lista de Alunos', style: context.textTheme.titleLarge),
      ],
    );
  }
}
