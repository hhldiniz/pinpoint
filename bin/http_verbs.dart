class HttpVerbs {
  String value;
  static _Get get = _Get();
  static _Post post = _Post();
  static _Put put = _Put();
  static _Delete delete = _Delete();

  static get availableVerbs => [get, post, put, delete];

  HttpVerbs(this.value);
}

class _Get extends HttpVerbs {
  _Get() : super("get");
}

class _Post extends HttpVerbs {
  _Post() : super("post");
}

class _Delete extends HttpVerbs {
  _Delete() : super("delete");
}

class _Put extends HttpVerbs {
  _Put() : super("put");
}
