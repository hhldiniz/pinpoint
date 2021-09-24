import 'app.dart';
import 'controllers/hello_world_controller.dart';

void main(List<String> args) async {
  var app = App();
  app.registerController(HelloWorldController("/"));
  await app.start();
}
