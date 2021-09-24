import 'package:shelf/shelf.dart';

import '../exceptions/http_verb_not_supported.dart';
import '../exceptions/not_implemented_exception.dart';
import '../http_verbs.dart';

abstract class BaseController {
  String route;

  BaseController(this.route);

  Response onRequestReceived(Request request) {
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

  Response get(Request request) {
    throw NotImplementedException();
  }

  Response post(Request request) {
    throw NotImplementedException();
  }

  Response delete(Request request) {
    throw NotImplementedException();
  }

  Response put(Request request) {
    throw NotImplementedException();
  }
}
