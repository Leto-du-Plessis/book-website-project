import 'package:flutter/material.dart';
import 'package:super_editor/super_editor.dart';

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

    _document = MutableDocument(
      nodes: [
        ParagraphNode( 
          id: Editor.createNodeId(),
          text: AttributedText('This is a header'),
          metadata: {
            'blockType': header1Attribution,
          }
        ),
        ParagraphNode(  
          id: Editor.createNodeId(),
          text: AttributedText('This is the first paragraph'),
        ),
      ],
    );
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
                "maxWidth": double.infinity,
              },
            ),
          ], 
          inlineTextStyler: inlineTextStyler
        ),
      ),
    );
  }
}

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