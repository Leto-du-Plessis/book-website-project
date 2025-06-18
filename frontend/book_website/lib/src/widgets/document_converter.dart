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

  static MutableDocument toDocument(Map<String, dynamic> json) {
    final nodes = (json['nodes'] as List)
      .map<DocumentNode>((nodeJson) => deserializeNode(nodeJson))
      .toList();
    return MutableDocument(nodes: nodes);
  }

  static bool _isAttributionKey(String key) {
    return key == 'blockType';
  }

  static Map<String, dynamic> deserializeMetadata(Map<String, dynamic>? json) {
    if (json == null) return {};
    final result = <String, dynamic>{};
    json.forEach((key, value) {
      if (_isAttributionKey(key)) {
        result[key] = NamedAttribution(value);
      } else {
        result[key] = value;
      }
    });
    return result;
  }

  static DocumentNode deserializeNode(Map<String, dynamic> nodeJson) {
    final type = nodeJson['type'];
    switch (type) {
      case 'paragraph':
        return ParagraphNode(id: nodeJson['id'], text: AttributedText(nodeJson['text']), metadata: deserializeMetadata(nodeJson['metadata']));
      default:
      throw UnimplementedError('Unknown node type: $type');
    }
  }

  static Map<String, dynamic> toJson(MutableDocument doc) {

    return {
      'nodes': getNodes(doc).map((node) => serializeNode(node)).toList(),
    };
  }

  static List<DocumentNode> getNodes(MutableDocument doc) {
    return [
      for (var i = 0; i < doc.nodeCount; i++) 
        if (doc.getNodeAt(i) case final node?) node
    ];
  }

  static Map<String, dynamic> serializeMetadata(Map<String, dynamic>? metadata) {
    if (metadata == null) return {};
    final result = <String, dynamic>{};
    metadata.forEach((key, value) {
      if (value is NamedAttribution) {
        result[key] = value.id;
      } else {
        result[key] = value;
      }
    });
    return result;
  }

  static Map<String, dynamic> serializeNode(DocumentNode node) {
    if (node is ParagraphNode) {
      return {
        'id': node.id,
        'type': 'paragraph',
        'text': node.text.toPlainText(), // bad, need to replace with logic to handle spans
        'metadata': serializeMetadata(node.metadata),
      };
    }
    throw UnimplementedError('Serialization not supported for ${node.runtimeType}.');
  }

}