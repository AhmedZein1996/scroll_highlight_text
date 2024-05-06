import 'package:flutter/material.dart';
import 'package:scroll_highlight_text/src/styling/app_spacing.dart';
import 'package:scroll_highlight_text/src/styling/app_styles.dart';

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
  List<TextSpan>? textSpans;

  @override
  void initState() {
    super.initState();
    textSpans = _initTextSpans();
  }

  void applyHighlightedText(final List<TextSpan> spans) {
    setState(() {
      textSpans = spans.isEmpty ? _initTextSpans() : spans;
      if (spans.isEmpty) {
        scrollController.animateTo(0,
            duration: widget.durationOfScroll,
            curve: widget.animationCurveOfScroll);
      }
    });
  }

  List<TextSpan> _initTextSpans() {
    return [
      TextSpan(
        text: widget.text,
        style: widget.unHighlightedTextStyle,
      )
    ];
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
