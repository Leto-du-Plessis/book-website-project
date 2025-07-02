import 'package:flutter/foundation.dart';

import '../models/book_summary.dart';
import '../services/services.dart';

typedef ListOfBooks = List<BookSummary>;

class HomePageState extends ChangeNotifier {

  final BookListService _bookListService;

  String? searchText;
  String? genreFilter;
  String? tagFilter;

  ListOfBooks? _customList;
  ListOfBooks? _trendingList;
  ListOfBooks? _fantasyList;
  ListOfBooks? _scifiList;

  HomePageState(this._bookListService);

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