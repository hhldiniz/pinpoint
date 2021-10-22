import '../../model/person.dart';
import '../person_data_source.dart';

class PersonLocalDataSource implements PersonDataSource {
  
  @override
  Future<List<Person>> getAll() {
    throw UnimplementedError();
  }
}
