import 'package:flutter/foundation.dart';

import '../models/book_summary.dart';
import '../services/services.dart';

typedef ListOfBooks = List<BookSummary>;

class HomePageState extends ChangeNotifier {

  final BookListService _bookListService;

  String? _searchText;
  String? _genreFilter;
  String? _tagFilter;

  ListOfBooks? _customList;

  int _lastSearchRequestId = 0;

  ListOfBooks? _trendingList;
  ListOfBooks? _fantasyList;
  ListOfBooks? _scifiList;

  HomePageState(this._bookListService);

  void updateSearchText(String? search) {
    _searchText = search;
    _refreshCustomList();
  }

  void updateGenreFilter(String? genre) {
    _genreFilter = genre;
    _refreshCustomList();
  }

  void updateTagFilter(String? tag) {
    _tagFilter = tag;
    _refreshCustomList();
  }

  void _refreshCustomList() async {
    final int requestId = ++_lastSearchRequestId;

    final result = await _bookListService.fetchCustomBookList(
      search: _searchText,
      genre: _genreFilter,
      tag: _tagFilter,
    );

    if (requestId == _lastSearchRequestId) {
      _customList = result;
      notifyListeners();
    }
  }

  Future<void> getTrendingList() async {
    ListOfBooks list = await _bookListService.fetchTrendingBookList();
    _trendingList = list;
    notifyListeners();
  }

  Future <void> getFantasyList() async {
    ListOfBooks list = await _bookListService.fetchFantasyBookList();
    _fantasyList = list;
    notifyListeners();
  }

  Future <void> getScifiList() async {
    ListOfBooks list = await _bookListService.fetchScifiBookList();
    _scifiList = list;
    notifyListeners();
  }

  ListOfBooks? get customList {
    return _customList;
  }

  ListOfBooks? get trendingList {
    return _trendingList;
  }

  ListOfBooks? get fantasyList {
    return _fantasyList;
  }

  ListOfBooks? get scifiList {
    return _scifiList;
  }

  List<String>? get customBookNames =>
    _customList?.map((book) => book.title).toList();

  List<String>? get trendingBookNames =>
    _trendingList?.map((book) => book.title).toList();

  List<String>? get fantasyBookNames =>
    _fantasyList?.map((book) => book.title).toList();

  List<String>? get scifiBookNames =>
    _scifiList?.map((book) => book.title).toList();
}