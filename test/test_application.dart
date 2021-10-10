import '../bin/app.dart';
import '../reference/hello_world_controller.dart';
import '../reference/post_data_controller.dart';

void main(List<String> args) async {
  var app = App();
  app.registerController(HelloWorldController("/hello_world"));
  app.registerController(PostDataController("/post_data"));
  await app.start();
}
