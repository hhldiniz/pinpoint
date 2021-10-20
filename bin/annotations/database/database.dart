import 'dao.dart';

class Database {
  final List<Dao> _daoList;

  Database(this._daoList);

  T getDao<T extends Dao>() {
    return _daoList
        .firstWhere((element) => element.runtimeType == T.runtimeType) as T;
  }
}
