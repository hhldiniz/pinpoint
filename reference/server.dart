import '../bin/app.dart';
import 'hello_world_controller.dart';
import 'post_data_controller.dart';

void main(List<String> args) async {
  var app = PinpointApp();
  app.registerController(HelloWorldController("/"));
  app.registerController(PostDataController("/post_data"));
  await app.start();
}
