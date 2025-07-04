import 'package:flutter/material.dart';
import '../widgets/custom_search_bar.dart';
class SearchOptionsWindow extends StatelessWidget {
  const SearchOptionsWindow({super.key});

@override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: BoxBorder.all()
      ),
      child: CustomSearchBar()

    );

  }

}
