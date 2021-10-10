import 'package:shelf/shelf.dart';

import '../bin/controllers/base_controller.dart';

class HelloWorldController extends BaseController {
  HelloWorldController(String route) : super(route);

  @override
  Future<Response> get(Request request) async {
    return Response.ok("Hello World");
  }
}
