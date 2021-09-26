import 'package:shelf/shelf.dart';

import '../exceptions/http_verb_not_supported.dart';
import '../http_verbs.dart';

abstract class BaseController {
  String route;

  BaseController(this.route);

  Future<Response> onRequestReceived(Request request) async {
    String incommingVerb = request.method.toLowerCase();
    if (incommingVerb == HttpVerbs.get.value) {
      return get(request);
    } else if (incommingVerb == HttpVerbs.post.value) {
      return post(request);
    } else if (incommingVerb == HttpVerbs.put.value) {
      return put(request);
    } else if (incommingVerb == HttpVerbs.delete.value) {
      return delete(request);
    } else {
      throw HttpVerbNotSupportedException();
    }
  }

  Future<Response> get(Request request) async {
    return Response(405);
  }

  Future<Response> post(Request request) async {
    return Response(405);
  }

  Future<Response> delete(Request request) async {
    return Response(405);
  }

  Future<Response> put(Request request) async {
    return Response(405);
  }
}
