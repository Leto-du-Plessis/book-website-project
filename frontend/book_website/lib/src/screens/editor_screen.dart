import 'package:flutter/material.dart';
import 'package:super_editor/super_editor.dart';

import '../widgets/document_converter.dart';
import '../widgets/split_view.dart';
import '../utilities/text_styles.dart';
import 'editor_window.dart';
import 'editor_controls_window.dart';

class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  late final MutableDocument _document;
  late final MutableDocumentComposer _composer;
  late final Editor _editor;

  @override
  void initState() {
    super.initState();

    _document = DocumentConverter.defaultDocument();
    _composer = MutableDocumentComposer();
    _editor = createDefaultDocumentEditor(document: _document, composer: _composer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplitView(
        leftWidget: EditorWindow(editor: _editor), 
        rightWidget: EditorControlsWindow(), 
        canSquashLeft: false,
      ),
    );
  }
}
