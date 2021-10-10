import 'dart:mirrors';

import 'package:shelf/shelf.dart';

import '../annotations/serialization.dart';
import '../enum/content_types.dart';
import '../reflection/activator.dart';
import '../util/type_caster.dart';
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

  Map<String, String> _parseBodyData(
      String rawBodyContent, ContentType contentType) {
    Map<String, String> parsedResult = {};
    if (contentType is FormData) {
      var mainContentPattern = RegExp("name=\"\\w+\"", multiLine: true);
      mainContentPattern.allMatches(rawBodyContent).forEach((match) {
        var fieldName =
            match.group(0)?.split("=")[1].replaceAll("\"", "") ?? "";
        print(fieldName);
      });
    } else if (contentType is XWWFormUrlEncoded) {
      print(rawBodyContent);
      parsedResult.addEntries(rawBodyContent.split("&").map((e) {
        var aux = e.split("=");
        return MapEntry(aux[0], aux[1]);
      }));
    } else {}
    return parsedResult;
  }

  @override
  Future<Response> post(Request request) async {
    var bodyContentFuture = request.readAsString();

    final InstanceMirror genericTypeMirror =
        reflect(Activator.createInstance(T));

    Map<String, dynamic> parsedBodyData = _parseBodyData(
              await bodyContentFuture,
              ContentType.fromString(request.headers['content-type'] ?? ""));

    for (var declaration in genericTypeMirror.type.declarations.values) {
      if (declaration is VariableMirror) {
        try {
          var annotation = declaration.metadata
              .firstWhere((element) => element.reflectee is SerializedField)
              .reflectee as SerializedField;
          Type targetType = declaration.type.reflectedType;

          var fieldNameToSet = MirrorSystem.getName(declaration.simpleName);
          genericTypeMirror.setField(
              declaration.simpleName,
              TypeCaster.cast(
                  parsedBodyData[annotation.fieldName ?? fieldNameToSet],
                  targetType));
        } catch (e) {
          print(e);
        }
      }
    }
    return postSerialized(request, genericTypeMirror.reflectee);
  }

  Future<Response> postSerialized(Request request, T model);
}
