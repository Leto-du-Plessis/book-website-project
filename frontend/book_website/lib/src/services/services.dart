import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/book_summary.dart';

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
      throw Exception('Failed to load document: ${response.statusCode}');
    }
  }
}

class BookListService {

  final String apiURL = "http://127.0.0.1:8000";

  BookListService();

  Future<List<BookSummary>> fetchBookList() async {
    final response = await http.get(Uri.parse('$apiURL/books'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => BookSummary.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

}