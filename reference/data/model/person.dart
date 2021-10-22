import '../../../bin/annotations/serialization.dart';
import '../../../bin/annotations/database/entity.dart';

@Entity("Person")
class Person {
  @SerializedField("name")
  String? name;

  @SerializedField("age")
  int? age;
}
