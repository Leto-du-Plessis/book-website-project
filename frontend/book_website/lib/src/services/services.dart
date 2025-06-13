import 'package:http/http.dart' as http;

/// Document service which can fetch documents from the backend
class DocumentService {

  final String apiURL = "http://127.0.0.1:8000";

  DocumentService();

  Future<String> fetchDocument({String? name}) async {
    final uri = Uri.parse('$apiURL/get_document/').replace(
      queryParameters: name != null ? {'name': name} : null,
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load codument: ${response.statusCode}');
    }
  }
}