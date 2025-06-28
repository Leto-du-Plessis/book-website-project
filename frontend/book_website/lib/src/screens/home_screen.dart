import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';
import 'reader_screen.dart';
import '../models/app_state.dart';
import '../widgets/user_profile_image.dart';
import '../widgets/split_view.dart';

class HomeScreen extends StatelessWidget {

  HomeScreen({super.key});

  @override build(BuildContext context) {

    final imageBytes = context.watch<AppState>().profileImageBytes;
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
                  builder: (_) => ReaderScreen(),
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
      body: const SplitView(leftWidget: Text("Left"), rightWidget: Text("Right")),
    );
  }
}