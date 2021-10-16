import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:test_process/test_process.dart';

void main() {
  final port = '8080';
  final host = 'http://0.0.0.0:$port';
  TestProcess? serverProcess;

  setUp(() async {
    serverProcess = await TestProcess.start(
      'dart',
      ['reference/server.dart'],
      environment: {'PORT': port},
    );
  });

  test('Hello World', () async {
    addTearDown(() => serverProcess?.kill());
    final response = await get(Uri.parse(host + '/'));
    expect(response.statusCode, 200);
    expect(response.body, 'Hello World');
  });

  test("Serialize Data Test", () async {
    addTearDown(() => serverProcess?.kill());
    var name = "John";
    var age = "20";
    final response = await post(Uri.parse(host + '/post_data'),
        body: {'name': name, 'age': age});
    expect(response.statusCode, 200);
    expect(response.body, "Data received: Person = $name - $age");
  });

  test('404', () async {
    addTearDown(() => serverProcess?.kill());
    final response = await get(Uri.parse(host + '/foobar'));
    expect(response.statusCode, 404);
  });
}
