import 'dart:convert';
import 'dart:mirrors';

import 'package:shelf/shelf.dart';

import '../annotations/serialization.dart';
import '../reflection/activator.dart';
import 'base_controller.dart';

abstract class SerializedDataController<T> extends BaseController {
  SerializedDataController(String route) : super(route);

  @override
  Future<Response> post(Request request) async {
    var instanceOfGeneric = Activator.createInstance(T);
    final DeclarationMirror clazzDeclaration = reflectClass(T);
    final ClassMirror serializedFieldAnnotationMirror =
        reflectClass(SerializedField);
    final List<InstanceMirror> annotationInstsanceMirror = clazzDeclaration
        .metadata;

    for (var im in annotationInstsanceMirror) {
      final serializedFieldInstance = (im.reflectee as SerializedField);
      var body = jsonDecode(await request.readAsString());

      try {
        body.entries.firstWhere(
            (element) => element.key == serializedFieldInstance.fieldName);
      } catch (e) {
        //IGNORE
      }
    }
    return postSerialized(request, instanceOfGeneric);
  }

  Future<Response> postSerialized(Request request, T model);
}
