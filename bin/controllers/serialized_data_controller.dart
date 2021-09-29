import 'dart:convert';
import 'dart:mirrors';

import 'package:shelf/shelf.dart';

import '../annotations/serialization.dart';
import '../reflection/activator.dart';
import 'base_controller.dart';

abstract class SerializedDataController<T> extends BaseController {
  SerializedDataController(String route) : super(route);

  T instantiate(
      ClassMirror classMirror, Symbol constructorName, List positional,
      [Map<Symbol, dynamic>? named]) {
    return classMirror
        .newInstance(constructorName, positional, named ?? {})
        .reflectee as T;
  }

  @override
  Future<Response> post(Request request) async {
    final InstanceMirror genericTypeMirror =
        reflect(Activator.createInstance(T));

    for (var declaration
        in genericTypeMirror.type.declarations.values.toList()) {
      if (declaration is VariableMirror) {
        try {
          var annotation = declaration.metadata
              .firstWhere((element) => element.reflectee is SerializedField)
              .reflectee as SerializedField;
          var fieldNameToSet = MirrorSystem.getName(declaration.simpleName);
          Map<String, dynamic> mockedData =
              jsonDecode("{\"$fieldNameToSet\": \"John\"}");
          genericTypeMirror.setField(declaration.simpleName,
              mockedData[annotation.fieldName ?? fieldNameToSet]);
        } catch (e) {
          print(e);
        }
      }
    }
    return postSerialized(request, genericTypeMirror.reflectee);
  }

  Future<Response> postSerialized(Request request, T model);
}
