import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ThemedHtmlText extends StatelessWidget {
  final String htmlContent;

  const ThemedHtmlText({super.key, required this.htmlContent});

  @override
  Widget build(BuildContext context) {
    Map<String, Style> textStyle = {};
    final FontStyle? normalStyle =
        Theme.of(context).textTheme.bodyMedium?.fontStyle;
    if (normalStyle != null) {
      textStyle['p'] = Style(fontStyle: normalStyle);
    }

    final FontStyle? boldStyle = Theme.of(context)
        .textTheme
        .bodyLarge
        ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold)
        .fontStyle;

    if (boldStyle != null) {
      textStyle['b'] = Style(fontStyle: boldStyle);
    }

    return Html(data: htmlContent.replaceAll('\n', '<br>'), style: textStyle);
  }
}
