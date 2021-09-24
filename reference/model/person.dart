import '../../bin/annotations/serialization.dart';

@SerializedModel()
class Person {
  
  @SerializedField("name")
  String? name;
}
