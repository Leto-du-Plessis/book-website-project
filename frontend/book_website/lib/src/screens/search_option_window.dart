import 'package:flutter/material.dart';
import '../widgets/custom_search_bar.dart';
import 'package:book_website/src/models/home_page_state.dart';
import 'package:provider/provider.dart';

const List<String> list = <String>['Any', 'Fantasy', 'Sci-fi', 'Adventure', 'Romance', 'I\'ve run out']; 

class SearchOptionsWindow extends StatelessWidget {
  const SearchOptionsWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 65,
            decoration: BoxDecoration(
              border: BoxBorder.all()
            ),
            child: CustomSearchBar()
          ),
          Text('Seach by Genre', textAlign: TextAlign.left,),
          GenreButton()
        ]
      )
    ); 
  }
}


class GenreButton extends StatefulWidget{
  const GenreButton({super.key});

  @override
  State<GenreButton> createState() => _GenreButtonState();
}

class _GenreButtonState extends State<GenreButton> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
        final text = value =="Any"? null: value;
        context.read<HomePageState>().updateGenreFilter(text);
      },
      items:
        list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }
      ).toList(),
    );
  }
}

