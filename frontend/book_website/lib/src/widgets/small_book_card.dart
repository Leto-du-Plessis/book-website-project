import 'package:flutter/material.dart';

import '../models/book_summary.dart';

class SmallBookCard extends StatelessWidget {

  final String title;
  final String? tagline;
  final String? imageId;

  const SmallBookCard({
    super.key,
    required this.title,
    this.tagline,
    this.imageId,
  });

  SmallBookCard.fromBookSummary({
    super.key, 
    required BookSummary bookSummary,
    }) : title = bookSummary.title,
         tagline = bookSummary.tagline,
         imageId = bookSummary.imageId;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  

}