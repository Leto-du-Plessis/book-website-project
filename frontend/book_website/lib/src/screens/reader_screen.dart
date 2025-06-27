import 'package:flutter/material.dart';
import 'package:super_editor/super_editor.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';
import 'reader_window.dart';
import '../models/app_state.dart';
import '../widgets/user_profile_image.dart';
import '../widgets/document_converter.dart';
import '../utilities/text_styles.dart';

/// The ReaderScreen [StatelessWidget] is the primary [Widget] responsible for displaying non editable [Document]s. 
/// If decorations are not required, i.e. the reader is to be integrated into another [Widget], [ReaderWindow] should be used instead.
class ReaderScreen extends StatefulWidget {

  final Document document;
  final Stylesheet styleSheet;

  ReaderScreen({super.key, Document? doc, Stylesheet? sheet})
    : document = doc ?? DocumentConverter.defaultDocument(),
      styleSheet = sheet ?? TextStyles.defaultStyleSheet;

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  double _fontSizeDelta = 20.0;

  @override
  Widget build(BuildContext context) {
    final imageBytes = context.watch<AppState>().profileImageBytes;
    return Scaffold(
      appBar: AppBar( 
        title: const Text('Reader'),
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
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
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            border: BoxBorder.all(
              color: Theme.of(context).colorScheme.outline, 
              width: 4.0
            ),
          ),
          child: ReaderWindow(document: widget.document, style: TextStyles.styleSheetIncrementFontSize(widget.styleSheet, _fontSizeDelta))
        ),
      )
    );
  }
}
