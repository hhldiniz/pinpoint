class TypeCaster {
  static Object? cast(String source, Type targetType) {
    switch (targetType) {
      case int:
        return int.parse(source);
      case double:
        return double.parse(source);
      case bool:
        return source.toLowerCase() == "true" || source == "1";
      default:
        return source;
    }
  }
}
