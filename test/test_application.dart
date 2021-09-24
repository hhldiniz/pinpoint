import 'package:shelf/shelf.dart';

import '../bin/app.dart';
import '../bin/controllers/base_controller.dart';

class TestController extends BaseController {
  TestController(String route) : super(route);

  @override
  Response get(Request request) {
    return Response.ok("Hello World!");
  }
}

void main(List<String> args) async {
  var app = App();
  app.registerController(TestController("/hello_world"));
  await app.start();
}
