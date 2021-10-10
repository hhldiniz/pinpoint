import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:test_process/test_process.dart';

void main() {
  final port = '8080';
  final host = 'http://0.0.0.0:$port';

  setUp(() async {
    await TestProcess.start(
      'dart',
      ['run', 'test/test_server.dart'],
      environment: {'PORT': port},
    );
  });

  test('Hello World', () async {
    final response = await get(Uri.parse(host + '/hello_world'));
    expect(response.statusCode, 200);
    expect(response.body, 'Hello World');
  });

  test("Serialize Data Test", () async {
    final response = await post(Uri.parse(host + '/post_data'),
        body: {'name': 'John', 'age': '20'});
    expect(response.statusCode, 200);
  });

  test('404', () async {
    final response = await get(Uri.parse(host + '/foobar'));
    expect(response.statusCode, 404);
  });
}
