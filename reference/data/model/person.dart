import '../../../bin/annotations/serialization.dart';
import '../../../bin/annotations/database/entity.dart';
import '../../../bin/annotations/database/column.dart';

@Entity("Person")
class Person {
  
  @SerializedField("name")
  @Column(isPrimaryKey: true)
  String? name;

  @SerializedField("age")
  int? age;
}
