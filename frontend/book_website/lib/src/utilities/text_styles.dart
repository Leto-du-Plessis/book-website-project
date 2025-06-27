import 'package:flutter/material.dart';
import 'package:super_editor/super_editor.dart';

typedef AttributionStyler = TextStyle Function(Set<Attribution>, TextStyle);

class TextStyles {

  static AttributionStyler get defaultStyler {
    return (Set<Attribution> attributions, TextStyle base) {
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
    };
  }

  static Stylesheet get defaultStyleSheet {
    return Stylesheet(
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
    );
  }
  
}