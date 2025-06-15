import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart';
import 'package:super_editor/super_editor.dart';

class ReaderScreen extends StatefulWidget {
  const ReaderScreen({super.key});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  //final QuillController _controller = QuillController.basic();
  //final FocusNode _focusNode = FocusNode();
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
  Widget build(context) {
    return SuperEditor(
      editor: _editor,
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Reader'),
  //     ),
  //     body: SafeArea(
  //       child: Column(
  //         children: [
  //           QuillSimpleToolbar(
  //             controller: _controller,
  //           ),
  //           Expanded(
  //             child: QuillEditor.basic(
  //               controller: _controller,
  //               focusNode: _focusNode,
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   _focusNode.dispose();
  //   super.dispose();
  // }
}