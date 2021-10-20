import 'entity.dart';

abstract class Dao {
  insert(List<Entity> entity);

  delete(List<Entity> entity);

  update(List<Entity> entity);

  query(String query);
}
