import 'package:flutter/material.dart';
import 'package:super_editor/super_editor.dart';

import '../widgets/document_converter.dart';
import '../utilities/text_styles.dart';

class ReaderScreen extends StatefulWidget {
  const ReaderScreen({super.key});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  late final MutableDocument _document;
  late final MutableDocumentComposer _composer;
  late final Editor _editor;

  @override
  void initState() {
    super.initState();

    _document = DocumentConverter.defaultDocument();
    //print(DocumentConverter.toJson(DocumentConverter.defaultDocument()));
    //_document = DocumentConverter.toDocument(DocumentConverter.toJson(DocumentConverter.defaultDocument()));
    _composer = MutableDocumentComposer();
    _editor = createDefaultDocumentEditor(document: _document, composer: _composer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SuperEditor(
        editor: _editor,
        stylesheet: Stylesheet(
          rules: [
            StyleRule( 
              const BlockSelector("paragraph"),
              (doc, node) => {
                Styles.maxWidth: double.infinity,
              },
            ),
            StyleRule( 
              const BlockSelector("header1"),
              (doc, node) => {
                Styles.textAlign: TextAlign.center,
                Styles.padding: CascadingPadding.all(16),
                Styles.maxWidth: double.infinity,
              }
            )
          ], 
          inlineTextStyler: TextStyles.defaultStyler
        ),
      ),
    );
  }
}
