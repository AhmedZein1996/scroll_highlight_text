import 'package:flutter/material.dart';
import 'package:scroll_highlight_text/src/styling/app_spacing.dart';
import 'package:scroll_highlight_text/src/styling/app_styles.dart';

import 'helper/text_scroll_highlight_helper.dart';

GlobalKey<HighlightedTextScrollableState> scrollToHighlightedTextGlobalKey =
    GlobalKey();

class HighlightedTextScrollable extends StatefulWidget {
  final String text;
  final TextStyle highlightedTextStyle;
  final TextStyle unHighlightedTextStyle;
  final EdgeInsetsGeometry padding;
  final Duration durationOfScroll;
  final Curve animationCurveOfScroll;

  HighlightedTextScrollable({
    required this.text,
    this.durationOfScroll = const Duration(milliseconds: 400),
    this.animationCurveOfScroll = Curves.ease,
    this.highlightedTextStyle = AppStyles.highlightedTextStyle,
    this.unHighlightedTextStyle = AppStyles.unHighlightedTextStyle,
    this.padding = const EdgeInsets.symmetric(
        horizontal: AppSpacing.defaultPadding,
        vertical: AppSpacing.mediumPadding),
  }) : super(key: scrollToHighlightedTextGlobalKey);

  @override
  State<HighlightedTextScrollable> createState() =>
      HighlightedTextScrollableState();
}

class HighlightedTextScrollableState extends State<HighlightedTextScrollable> {
  final ScrollController scrollController = ScrollController();
  List<TextSpan> textSpans = [];

  @override
  void initState() {
    super.initState();

    textSpans = InitTextScrollHighlightHelper(
            scrollToHighlightedTextGlobalKey.currentState)
        ._initTextSpans(widget.text);
  }

  void applyHighlightedText(final List<TextSpan> spans) {
    textSpans = spans;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: widget.padding,
        controller: scrollController,
        child: RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
            children: textSpans,
          ),
        ),
      ),
    );
  }
}

class InitTextScrollHighlightHelper extends TextScrollHighlightHelper {
  final HighlightedTextScrollableState? _keyCurrentState;
  InitTextScrollHighlightHelper(this._keyCurrentState)
      : super(_keyCurrentState);
  List<TextSpan> _initTextSpans(String text) {
    List<String> parts = text.split(' ');
    return parts.map((part) {
      return TextSpan(
        text: '$part ',
        style: _keyCurrentState!.widget.unHighlightedTextStyle,
      );
    }).toList();
  }
}
