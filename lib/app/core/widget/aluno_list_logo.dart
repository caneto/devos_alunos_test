import 'dart:async';

import 'package:devos_alunos_test/app/core/ui/helpers/context_extension.dart';
import 'package:flutter/material.dart';

import '../navigator/alunos_list_navigator.dart';

class AlunoListLogo extends StatefulWidget {
  const AlunoListLogo({Key? key}) : super(key: key);

  @override
  State<AlunoListLogo> createState() => _AlunoListLogoState();
}

class _AlunoListLogoState extends State<AlunoListLogo> {

  _AlunoListLogoState() {
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
        Text('Lista de Alunos', style: context.headline6),
      ],
    );
  }
}
