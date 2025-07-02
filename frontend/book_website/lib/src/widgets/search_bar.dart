import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

@override
State<SearchBarWidget> createState() => _SearchBar();
}

class _SearchBar extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();
  
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0)
                )
              ),


 
            )
            
            )
      )       
    );
  }
}
