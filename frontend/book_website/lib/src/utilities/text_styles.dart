import 'package:flutter/material.dart';
import 'package:super_editor/super_editor.dart';

typedef AttributionStyler = TextStyle Function(Set<Attribution>, TextStyle);

class TextStyles {

  static double _minFontSize(double fontSize) {
    return fontSize >= 2.0 ? fontSize : 2.0;
  }

  static double _maxFontSize(double fontSize) {
    return fontSize <= 100.0 ? fontSize : 100.0;
  }

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
            Styles.textStyle: const TextStyle(fontSize: 16.0)
          },
        ),
        StyleRule( 
          const BlockSelector("header1"),
          (doc, node) => {
            Styles.textAlign: TextAlign.center,
            Styles.padding: CascadingPadding.all(16),
            Styles.maxWidth: double.infinity,
            Styles.textStyle: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          }
        )
      ], 
      inlineTextStyler: TextStyles.defaultStyler
    );
  }

  static Stylesheet styleSheetIncrementFontSize(Stylesheet styleSheet, double fontSizeDelta,) {
    List<StyleRule> updatedRules = [];

    for (final rule in styleSheet.rules) {
      Map<String, dynamic> newStyler(Document document, DocumentNode node) {
        final original = rule.styler(document, node);
        final updated = <String, dynamic>{};
        original.forEach((key, value) {
          if (key == Styles.textStyle && value is TextStyle) {
            final base = value;
            updated[key] = base.copyWith(
              fontSize: _minFontSize(_maxFontSize((base.fontSize ?? 14.0) + fontSizeDelta)),
            );
          } else {
            updated[key] = value;
          }
        });
        return updated;
      }
      updatedRules.add(StyleRule(rule.selector, newStyler));
    }
    return Stylesheet(
      documentPadding: styleSheet.documentPadding,
      rules: updatedRules,
      inlineTextStyler: styleSheet.inlineTextStyler,
    );
  }
}