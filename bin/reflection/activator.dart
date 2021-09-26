import 'dart:mirrors';

class Activator {
  static createInstance(Type? type,
      [Symbol? constructor,
      List? arguments,
      Map<Symbol, dynamic>? namedArguments]) {
    if (type == null) {
      throw ArgumentError("type: $type");
    }

    constructor ??= const Symbol("");

    arguments ??= const [];

    var typeMirror = reflectType(type);
    if (typeMirror is ClassMirror) {
      return typeMirror
          .newInstance(constructor, arguments, namedArguments ?? {})
          .reflectee;
    } else {
      throw ArgumentError("Cannot create the instance of the type '$type'.");
    }
  }
}