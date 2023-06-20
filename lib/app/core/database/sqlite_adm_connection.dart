
import 'package:devos_alunos_test/app/core/database/sqlite_connection_fectory.dart';
import 'package:flutter/cupertino.dart';

class SqliteAdmConnection with WidgetsBindingObserver {
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final connection = SqliteConnectionFectory();

    switch(state) {
      case AppLifecycleState.resumed: // Aplicativo aberto em tela
        break;
      case AppLifecycleState.inactive:  // Clique na bolinha do meio
      case AppLifecycleState.paused: // Atendeu alguma ligação ou outro app abriu por cima
      case AppLifecycleState.detached:  // Matou o app
        connection.closeConnection();
        break;
    }
    super.didChangeAppLifecycleState(state);
  }
  
}