import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_widget.dart';
import 'core/database/sqlite_connection_fectory.dart';

class AppModule extends StatelessWidget {
  const AppModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => SqliteConnectionFectory(),
          lazy: false,
        ),
      ],
      child: const AppWidget(),
    );
  }
}
