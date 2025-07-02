import 'package:book_website/src/screens/carousel_window.dart';
import 'package:book_website/src/screens/search_option_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';
import 'reader_screen.dart';
import 'editor_screen.dart';
import '../models/app_state.dart';
import '../models/book_summary.dart';
import '../models/home_page_state.dart';
import '../services/services.dart';
import '../widgets/user_profile_image.dart';
import '../widgets/split_view.dart';
import '../widgets/small_book_card.dart';

class HomeScreen extends StatelessWidget {

  final BookListService _bookListService = BookListService(); 

  HomeScreen({super.key});

  @override build(BuildContext context) {

    final imageBytes = context.watch<AppState>().profileImageBytes;

    return ChangeNotifierProvider(
      create: (_) => HomePageState(_bookListService),
      child: Scaffold( 
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
        body: SplitView(leftWidget: CarouselWindow(), rightWidget: SearchOptionsWindow()),
      ),
    );
  }
}