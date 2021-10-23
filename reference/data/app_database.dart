import 'dart:indexed_db';

import '../../bin/annotations/database/database.dart';
import 'dao/person_dao.dart';
import 'model/person.dart';

@Database([Person], 1)
abstract class AppDatabase extends PinpointDatabase {
  PersonDao personDao();
}
