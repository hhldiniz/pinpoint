class HttpVerbNotSupportedException implements Exception {
  String cause =
      "The requested http verb is not currently supported by the framework";
}
