class ContentType {
  String description;

  static final FormData formData = FormData();
  static final XWWFormUrlEncoded xwwFormUrlEncoded = XWWFormUrlEncoded();
  static final NoContentType noContentType = NoContentType();

  ContentType(this.description);
  // xWwwFormUrlencoded, none

  static fromString(String description) {
    if (description.contains("multipart/form-data")) {
      return formData;
    } else if (description.contains("x-www-form-urlencoded")) {
      return xwwFormUrlEncoded;
    } else {
      return noContentType;
    }
  }
}

class FormData extends ContentType {
  FormData() : super("form-data");
}

class XWWFormUrlEncoded extends ContentType {
  XWWFormUrlEncoded() : super("x-www-form-urlencoded");
}

class NoContentType extends ContentType {
  NoContentType() : super("none");
}
