import 'package:flutter/material.dart';
import 'package:super_editor/super_editor.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';
import 'reader_window.dart';
import '../models/app_state.dart';
import '../widgets/user_profile_image.dart';
import '../widgets/document_converter.dart';

class ReaderScreen extends StatelessWidget {

  final Document document;

  ReaderScreen({super.key, Document? doc})
    : document = doc ?? DocumentConverter.defaultDocument();

  @override
  Widget build(BuildContext context) {
    final imageBytes = context.watch<AppState>().profileImageBytes;
    return Scaffold(
      appBar: AppBar( 
        title: const Text('Home'),
         actions: [
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ReaderWindow(document: document),
      )
    );
  }

}
