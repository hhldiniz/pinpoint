import '../bin/app.dart';
import 'hello_world_controller.dart';

void main(List<String> args) async {
  var app = App();
  app.registerController(HelloWorldController("/"));
  await app.start();
}
