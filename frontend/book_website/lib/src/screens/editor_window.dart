import 'package:flutter/material.dart';
import 'package:super_editor/super_editor.dart';
import '../utilities/text_styles.dart';

class EditorWindow extends StatelessWidget {

  late final Editor editor;

  EditorWindow({super.key, required this.editor});

  @override
  Widget build(BuildContext context) {
    return SuperEditor(
      editor: editor,
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
    );
  }
}