import '../model/person.dart';

abstract class PersonDataSource {
  Future<List<Person>> getAll();
}