import '../../bin/annotations/serialization.dart';

class Person {
  @SerializedField("name")
  String? name;

  @SerializedField("age")
  int? age;
}
