import 'package:flutter/material.dart';
import 'package:super_editor/super_editor.dart';

import '../utilities/text_styles.dart';

/// A ReaderWindow [Widget] provides a non-editable view on a [Document].
/// Text styling is implemented via [TextStyles].
class ReaderWindow extends StatelessWidget {

  final Document document;
  final Stylesheet styleSheet;

  ReaderWindow({super.key, required this.document, Stylesheet? style})
    : styleSheet = style ?? TextStyles.defaultStyleSheet;

  @override  
  Widget build(BuildContext context) {
    return Scaffold(
      body: SuperReader(
        document: document,
        stylesheet: styleSheet,
      ),
    );
  }

}

