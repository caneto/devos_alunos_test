
import 'package:sqflite_common/sqlite_api.dart';

import 'migration.dart';

class MigrationV1 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
      create table todo (
        id Integer primary key autoincrement,
        nome varchar(500) not null,
        email varchar(200) not null,
        telefone varchar(200) not null,
        valor real not null,
        senha varchar(100) not null,
        situacao int
      )
    ''');
  }

  @override
  void upgrade(Batch batch) {}
  
}