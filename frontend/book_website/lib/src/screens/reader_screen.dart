import 'package:flutter/material.dart';
import 'package:super_editor/super_editor.dart';

import '../widgets/document_converter.dart';

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
          inlineTextStyler: inlineTextStyler
        ),
      ),
    );
  }
}

// This should probably be moved to a seperate class or something later.
// Edit this to change the text format.
TextStyle inlineTextStyler(Set<Attribution> attributions, TextStyle base) {
  TextStyle result = base;

  if (attributions.contains(boldAttribution)) {
    result = result.merge(const TextStyle(fontWeight: FontWeight.bold));
  }
  if (attributions.contains(italicsAttribution)) {
    result = result.merge(const TextStyle(fontStyle: FontStyle.italic));
  }
  if (attributions.contains(underlineAttribution)) {
    result = result.merge(const TextStyle(decoration: TextDecoration.underline));
  }
  if (attributions.contains(strikethroughAttribution)) {
    result = result.merge(const TextStyle(decoration: TextDecoration.lineThrough));
  }
  if (attributions.contains(header1Attribution)) {
    result = result.merge(const TextStyle(fontWeight: FontWeight.bold, fontSize: 30));
  }

  return result;
}