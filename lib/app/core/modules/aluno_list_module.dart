// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:devos_alunos_test/app/core/modules/aluno_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';

abstract class AlunoListModule {
  final Map<String, WidgetBuilder> _routers;
  final List<SingleChildWidget>? _bindings;
  
  AlunoListModule({
    List<SingleChildWidget>? bindings,
    required Map<String, WidgetBuilder> routers,
  })  : _routers = routers,
        _bindings = bindings;

  Map<String, WidgetBuilder> get routers {
    return _routers.map(
      (key, pageBuilder) => MapEntry(
        key,
        (_) => AlunoListPage(
          bindings: _bindings,
          page: pageBuilder,
        ),
      ),
    );
  }

  Widget getPage(String path, BuildContext context) {
    final widgetBuilder = _routers[path];
    if (widgetBuilder != null) {
      return AlunoListPage(
        page: widgetBuilder,
        bindings: _bindings,
      );
    }
    throw Exception();
  }
}
