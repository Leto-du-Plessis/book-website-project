import 'package:flutter/material.dart';

import 'package:super_editor/super_editor.dart';

class DocumentConverter {

  /// Creates a simple example [MutableDocument] object to act as a standin when testing UI features.
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

  /// Converts a stored Json representation of a [Document] into a [MutableDocument] object.
  static MutableDocument toDocument(Map<String, dynamic> json) {
    final nodes = (json['nodes'] as List)
      .map<DocumentNode>((nodeJson) => deserializeNode(nodeJson))
      .toList();
    return MutableDocument(nodes: nodes);
  }

  /// Checks whether the provided key is in the attribution key library.
  static bool _isAttributionKey(String key) {
    return key == 'blockType';
  }

  /// Converts a stored Json metadata string map into a valid String, Attribute map.
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

  /// Converts a stored Json node into a valid [DocumentNode].
  static DocumentNode deserializeNode(Map<String, dynamic> nodeJson) {
    final type = nodeJson['type'];
    switch (type) {
      case 'paragraph':
        return ParagraphNode(id: nodeJson['id'], text: AttributedText(nodeJson['text']), metadata: deserializeMetadata(nodeJson['metadata']));
      default:
      throw UnimplementedError('Unknown node type: $type');
    }
  }

  /// Converts a [MutableDocument] object into a serialized Json representation.
  static Map<String, dynamic> toJson(MutableDocument doc) {

    return {
      'nodes': getNodes(doc).map((node) => serializeNode(node)).toList(),
    };
  }

  /// Returns all the [DocumentNode] objects in the provided [MutableDocument].
  /// This is a helper function since the nodes getter has been removed from [MutableDocument].
  static List<DocumentNode> getNodes(MutableDocument doc) {
    return [
      for (var i = 0; i < doc.nodeCount; i++) 
        if (doc.getNodeAt(i) case final node?) node
    ];
  }

  /// Returns a serialized Json representation of the metadata of a [DocumentNode].
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

  /// Converts a [DocumentNode] object into a serialized Json String representation.
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