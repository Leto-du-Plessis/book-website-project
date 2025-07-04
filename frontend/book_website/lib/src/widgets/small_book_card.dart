import 'package:flutter/material.dart';

import '../models/book_summary.dart';

class SmallBookCard extends StatelessWidget {

  final String? title;
  final String? tagline;
  final String? imageId;

  const SmallBookCard({
    super.key,
    required this.title,
    this.tagline,
    this.imageId,
  });

  const SmallBookCard.loadingPlaceholder({super.key}) : 
    title = null,
    tagline = null,
    imageId = null;

  SmallBookCard.fromBookSummary({
    super.key, 
    required BookSummary bookSummary,
    }) : title = bookSummary.title,
         tagline = bookSummary.tagline,
         imageId = bookSummary.imageId;

@override
  Widget build(BuildContext context) {
    return Container( 
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
      ),
      child: Column(  
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          title == null ? const Center(child: CircularProgressIndicator()) : Text(title!),
          if (tagline != null) Text(tagline!),
        ]
      )
    );
  }
}