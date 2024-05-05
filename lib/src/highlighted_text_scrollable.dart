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
  final double horizontalPadding;
  final double verticalPadding;
  final Duration durationOfScroll;
  final Curve animationCurveOfScroll;

  HighlightedTextScrollable({
    required this.text,
    this.horizontalPadding = AppSpacing.defaultPadding,
    this.verticalPadding = AppSpacing.zero,
    this.durationOfScroll = const Duration(milliseconds: 400),
    this.animationCurveOfScroll = Curves.ease,
    this.highlightedTextStyle = AppStyles.highlightedTextStyle,
    this.unHighlightedTextStyle = AppStyles.unHighlightedTextStyle,
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
    TextScrollHighlightHelper.initCurrentState(
        scrollToHighlightedTextGlobalKey);
    textSpans = TextScrollHighlightHelper.initTextSpans(widget.text);
  }

  void applyHighlightedText(final List<TextSpan> spans) {
    textSpans = spans;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: widget.horizontalPadding,
          vertical: widget.verticalPadding,
        ),
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
