/*class EndPoints {
  static const String baserUrl = "https://dummyjson.com/";
  static const String template = "template/";
  static const String product = "products?limit=10&skip=0";
}*/
class EndPoints {
  static const String baseUrl = "https://dummyjson.com/";
  static const int limit = 10;

  static String products({required int page}) {
    final int skip = page * limit;
    return "products?limit=$limit&skip=$skip";
  }
}
