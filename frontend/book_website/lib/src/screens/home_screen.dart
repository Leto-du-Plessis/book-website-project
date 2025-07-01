import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';
import 'reader_screen.dart';
import 'editor_screen.dart';
import '../models/app_state.dart';
import '../models/book_summary.dart';
import '../widgets/user_profile_image.dart';
import '../widgets/split_view.dart';
import '../widgets/small_book_card.dart';

class HomeScreen extends StatelessWidget {

  HomeScreen({super.key});

  @override build(BuildContext context) {

    final imageBytes = context.watch<AppState>().profileImageBytes;
    final List<BookSummary>? bookList = context.watch<AppState>().bookList;

    // Temporary logic
    Widget leftWidget;

    if (bookList == null) {
      leftWidget = Center(
        child: ElevatedButton(
          onPressed: () => context.read<AppState>().fetchBookList(),
          child: const Text("Fetch Book List"),
        ),
      );
    } else {
      leftWidget = CarouselView(
        itemExtent: 500,
        children: bookList
            .map((book) => SmallBookCard.fromBookSummary(bookSummary: book))
            .toList(),
      );
    }

    return Scaffold( 
      appBar: AppBar( 
        title: const Text('Home'),
         actions: [
          IconButton(  
            icon: const Icon(Icons.book, size: 28),
            tooltip: 'Editor',
            onPressed: () {
              Navigator.push(  
                context,
                MaterialPageRoute(  
                  builder: (_) => EditorScreen(),
                ),
              );
            }
          ),
          IconButton(
            icon: 
              UserProfileImage(
                profileImageBytes: imageBytes,
                size: 40,
              ),
            tooltip: 'Login',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SplitView(leftWidget: leftWidget, rightWidget: Text("Right")),
    );
  }
}