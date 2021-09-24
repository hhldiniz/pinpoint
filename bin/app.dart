import 'dart:convert';
import 'dart:io';
import 'dart:mirrors';
import 'dart:typed_data';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'controllers/base_controller.dart';
import 'exceptions/not_implemented_exception.dart';
import 'http_verbs.dart';

//Represents the application
class App {
  String? ipAddress;
  String? port;

  final List<BaseController> _controllers = [];

  App({this.ipAddress, this.port});

  final _router = Router();
  
  //Register a controller in the app
  registerController(BaseController controller) {
    for (HttpVerbs verb in HttpVerbs.availableVerbs) {
      _checkHttpVerb(verb, controller);
      _router.add(
          verb.value, controller.route, controller.onRequestReceived);
      _controllers.add(controller);
    }
  }

  bool _checkHttpVerb(HttpVerbs httpVerb, BaseController targetController) {
    try {
      reflect(targetController).invoke(Symbol(httpVerb.toString()), []);
      return true;
    } on NotImplementedException catch (e) {
      print(e.cause);
    } catch (e) {
      print("Unexpected error occured");
      print(e);
    }
    return false;
  }

  //Starts the server application
  start() async {
    final ip = ipAddress != null
        ? InternetAddress.fromRawAddress(
            Uint8List.fromList(utf8.encode(ipAddress!)))
        : InternetAddress.anyIPv4;
    final _handler =
        Pipeline().addMiddleware(logRequests()).addHandler(_router);

    final port = int.parse(this.port ?? Platform.environment['PORT'] ?? '8080');
    final server = await serve(_handler, ip, port);
    print('Server listening on port ${server.port}');
  }
}
