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

    final InstanceMirror classInstanceMirror = reflect(instanceOfGeneric);

    final ClassMirror genericTypeMirror = classInstanceMirror.type;

    for (var declaration in genericTypeMirror.declarations.entries) {
      if (declaration.value is VariableMirror) {
        VariableMirror vb = declaration.value as VariableMirror;
        try {
          var annotation = vb.metadata
                  .firstWhere((element) => element.type is SerializedField)
              as SerializedField;
          Map<String, dynamic> mockedData =
              jsonDecode("{'${vb.simpleName}': 'John'}");
          genericTypeMirror.setField(
              vb.simpleName, mockedData[annotation.fieldName ?? vb.simpleName]);
        } catch (e) {
          print(e);
        }
      }
    }
    return postSerialized(request, instanceOfGeneric);
  }

  Future<Response> postSerialized(Request request, T model);
}
