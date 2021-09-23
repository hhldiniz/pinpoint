import 'package:shelf/shelf.dart';

import '../exceptions/not_implemented_exception.dart';

abstract class BaseController {
  String route;

  BaseController(this.route);

  void onRequestReceived(Request request);

  void get() {
    throw NotImplementedException();
  }

  void post() {
    throw NotImplementedException();
  }

  void delete() {
    throw NotImplementedException();
  }

  void put() {
    throw NotImplementedException();
  }
}
