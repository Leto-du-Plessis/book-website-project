import 'package:flutter/material.dart';
import 'package:super_editor/super_editor.dart';

import 'reader_window.dart';
import '../widgets/document_converter.dart';

class ReaderScreen extends StatelessWidget {

  final Document document;

  ReaderScreen({super.key, Document? doc})
    : document = doc ?? DocumentConverter.defaultDocument();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReaderWindow(document: document)
    );
  }

}
