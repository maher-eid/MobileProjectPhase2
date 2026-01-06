import 'package:http/http.dart' as http;

Future<void> testApi() async {
  try {
    print('API TEST STARTED');

    final url = Uri.http(
      'project2mobileapp.great-site.net',
      'getBooks.php',
    );

    final response = await http.get(url);

    print('STATUS CODE: ${response.statusCode}');
    print('RAW BODY: ${response.body}');
  } catch (e) {
    print('API ERROR: $e');
  }
}
