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
      var mainContentPattern = RegExp("name=\"\\w+\"\\s+\\w+", multiLine: true);
      parsedResult.addEntries(
          mainContentPattern.allMatches(rawBodyContent).map((match) {
        List<String> data = match.group(0)?.split(RegExp("\\n+")) ?? [];
        String fieldName = RegExp("\\w+")
                .stringMatch(data[0].split("=")[1]) ??
            "";
        String fieldValue =
            RegExp("\\w+").stringMatch(data[2]) ?? "";
        return MapEntry(fieldName, fieldValue);
      }));
    } else if (contentType is XWWFormUrlEncoded) {
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

    Map<String, String> parsedBodyData = _parseBodyData(await bodyContentFuture,
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
                  parsedBodyData[annotation.fieldName ?? fieldNameToSet] ?? "",
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
