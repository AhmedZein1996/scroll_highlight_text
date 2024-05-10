import 'package:flutter/material.dart';
import 'package:scroll_highlight_text/src/helper/text_scroll_highlight_helper.dart';
import 'package:scroll_highlight_text/src/styling/app_spacing.dart';
import 'package:scroll_highlight_text/src/styling/app_styles.dart';

GlobalKey<HighlightedTextScrollableState> scrollToHighlightedTextGlobalKey =
    GlobalKey();

class HighlightedTextScrollable extends StatefulWidget {
  /// The text content to be displayed and scrolled through.
  final String text;

  /// The controller of the text field where the user inputs the word to be searched.
  ///
  /// If [autoDisposeSearchController] is set to true (default), the controller
  /// will be disposed automatically when the widget is removed from the widget tree.
  /// If manual disposal is desired, set [autoDisposeSearchController] to false.
  /// Otherwise, you may encounter the error "A TextEditingController was used after being disposed."
  /// If [autoDisposeSearchController] is set to false, ensure to dispose the controller manually to avoid memory leaks and errors.
  final TextEditingController searchController;

  /// Auto dispose the [searchController] upon the destruction of widget from the widget tree. Default is [true]
  final bool autoDisposeSearchController;

  /// Text Directions
  ///
  /// `TextDirection.ltr`: Indicates that the text is laid out from left to right, which is the default direction for languages like English.
  /// `TextDirection.rtl`: Indicates that the text is laid out from right to left, which is the default direction for languages like Arabic and Hebrew.
  final TextDirection textDirection;

  /// The text style applied to highlighted words or phrases.
  final TextStyle highlightedTextStyle;

  /// The text style applied to the rest of the text.
  final TextStyle unHighlightedTextStyle;

  /// The internal padding around the text widget.
  /// Padding should only be applied internally within this widget, not from external sources.
  /// If you want to apply custom internal padding, make sure to pass it to `HighlightedTextScrollable`.
  /// This ensures that the padding is considered during the calculation process.
  ///
  /// This ensures that the `HighlightedTextScrollable` widget works correctly and scrolls to the position of the right word.
  final EdgeInsetsGeometry padding;

  /// The duration of the scrolling animation.
  final Duration durationOfScroll;

  /// The animation curve used for scrolling transitions.
  final Curve animationCurveOfScroll;

  HighlightedTextScrollable({
    required this.text,
    required this.searchController,
    this.autoDisposeSearchController = true,
    this.textDirection = TextDirection.ltr,
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
  String? searchControllerCurrentValue;
  @override
  void initState() {
    super.initState();
    searchControllerCurrentValue = '';
    textSpans = _initTextSpans();
    widget.searchController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    scrollController.dispose();
    if (widget.autoDisposeSearchController) {
      widget.searchController.dispose();
    }
    widget.searchController.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final String inputText = widget.searchController.text;
    if (_isInputTextNotEmpty(inputText)) {
      _updateSearchControllerCurrentValue(inputText);
    }

    _scrollToHighlightedText(inputText);
  }

  void _updateSearchControllerCurrentValue(String value) {
    searchControllerCurrentValue = value;
  }

  bool _isInputTextNotEmpty(String text) {
    return text.isNotEmpty;
  }

  void _scrollToHighlightedText(String inputText) {
    if (_isSearchControllerCurrentValueNotEmpty()) {
      TextScrollHighlight.scrollToHighlightedText(inputText);
    }
  }

  bool _isSearchControllerCurrentValueNotEmpty() {
    return searchControllerCurrentValue?.isNotEmpty ?? false;
  }

  void applyHighlightedText(final List<TextSpan> spans) {
    if (mounted) {
      setState(() {
        textSpans = spans.isEmpty ? _initTextSpans() : spans;
        if (spans.isEmpty) {
          scrollController.animateTo(0,
              duration: widget.durationOfScroll,
              curve: widget.animationCurveOfScroll);
        }
      });
    }
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
    return Directionality(
      textDirection: widget.textDirection,
      child: Expanded(
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
      ),
    );
  }
}
