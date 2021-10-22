import 'dart:web_gl';

import '../../../bin/annotations/database/dao.dart';
import '../../../bin/annotations/database/database_operations.dart';
import '../model/person.dart';

@Dao()
abstract class PersonDao {
  @Insert()
  insert();

  @Delete()
  delete();

  @Update()
  update();

  @Query("SELECT * FROM Person")
  Future<List<Person>> getAll();
}
