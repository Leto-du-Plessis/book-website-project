import 'package:flutter/material.dart';

import '../models/book_summary.dart';
import 'small_book_card.dart';

class CustomCarousel extends StatelessWidget {

  final List<BookSummary>? list;

  const CustomCarousel({super.key, this.list});

  List<SmallBookCard> _convertToCards(List<BookSummary> list) {
    List<SmallBookCard> newList = list.map((book) => SmallBookCard.fromBookSummary(bookSummary: book)).toList();
    return newList;
  }

  List<SmallBookCard> _createPlaceholderList() {
    List<SmallBookCard> newList = List.generate(5, (_) => SmallBookCard.loadingPlaceholder());
    return newList;
  }

  List<SmallBookCard> _createList() {
    List<SmallBookCard> newList = (list != null) ? _convertToCards(list!) : _createPlaceholderList();
    return newList;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: 200,
        child: CarouselView(  
          itemExtent: 200,
          children: _createList(),
        ),
      ),
    );
  }
}