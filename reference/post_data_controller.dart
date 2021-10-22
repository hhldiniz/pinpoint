import 'package:shelf/src/request.dart';
import 'package:shelf/src/response.dart';

import '../bin/controllers/serialized_data_controller.dart';
import 'data/model/person.dart';

class PostDataController extends SerializedDataController<Person> {
  PostDataController(String route) : super(route);

  @override
  Future<Response> postSerialized(Request request, Person model) async {
    return Response.ok("Data received: Person = ${model.name} - ${model.age}");
  }
}
