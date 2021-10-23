import '../../../bin/annotations/database/dao.dart';
import '../../../bin/annotations/database/database_operations.dart';
import '../model/person.dart';

@Dao()
abstract class PersonDao {
  @Insert()
  insert(List<Person> person);

  @Delete()
  delete(Person person);

  @Update()
  update(Person person);

  @Query("SELECT * FROM Person")
  Future<List<Person>> getAll();
}
