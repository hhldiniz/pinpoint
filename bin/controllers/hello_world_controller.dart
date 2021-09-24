import 'package:shelf/shelf.dart';

import 'base_controller.dart';

class HelloWorldController extends BaseController {
  HelloWorldController(String route) : super(route);

  @override
  Response get(Request request) {
    return Response.ok("Hello World");
  }
}
