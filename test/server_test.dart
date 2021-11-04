import 'package:http/http.dart';
import 'package:test/test.dart';

void main() {
  final port = '8080';
  final host = 'http://0.0.0.0:$port';

  test('Hello World', () async {
    // addTearDown(() => serverProcess?.kill());
    final response = await get(Uri.parse(host + '/'));
    expect(response.statusCode, 200);
    expect(response.body, 'Hello World');
  });

  test("Serialize Data Test", () async {
    var name = "John";
    var age = "20";
    var occupation = "Developer";
    final response = await post(Uri.parse(host + '/post_data'),
        body: {'name': name, 'age': age, 'occupation': occupation});
    expect(response.statusCode, 200);
    expect(response.body, "Data received: Person = $name - $age - $occupation");
  });

  test('404', () async {
    final response = await get(Uri.parse(host + '/foobar'));
    expect(response.statusCode, 404);
  });
}
