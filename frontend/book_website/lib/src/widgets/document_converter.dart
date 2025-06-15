import 'package:flutter/material.dart';
import 'package:super_editor/super_editor.dart';

class DocumentConverter {

  static MutableDocument defaultDocument() {
    MutableDocument document = MutableDocument(
      nodes: [
        ParagraphNode( 
          id: Editor.createNodeId(),
          text: AttributedText('Example Document'),
          metadata: {
            'blockType': header1Attribution,
          }
        ),
        ParagraphNode(  
          id: Editor.createNodeId(),
          text: AttributedText('This is an example document which contains example text and example layouts. It\'s frankly not very interesting and I really wouldn\'t waste your time or energy on reading this.'),
        ),
        ParagraphNode(
          id: Editor.createNodeId(), 
          text: AttributedText("This is the second paragraph and it exists only to highlight the fact that we can have multiple paragraphs. Woo, so exciting!")
        ),
        ParagraphNode(
          id: Editor.createNodeId(), 
          text: AttributedText("Oh, you wanted more? Whatchu think this is? Some kind of candy store?")
        )
      ],
    );
    return document;
  }

}