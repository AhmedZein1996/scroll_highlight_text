import 'package:flutter/cupertino.dart';

import '../highlighted_text_scrollable.dart';

class TextScrollHighlightHelper {
  static late HighlightedTextScrollableState? currentState;

  static void initCurrentState(GlobalKey<HighlightedTextScrollableState> key) {
    currentState = key.currentState;
  }

  static List<TextSpan> initTextSpans(String text) {
    List<String> parts = text.split(' ');
    return parts.map((part) {
      return TextSpan(
        text: '$part ',
        style: currentState!.widget.unHighlightedTextStyle,
      );
    }).toList();
  }

  static void scrollToHighlightedText(String inputText) {
    final keyCurrentState = scrollToHighlightedTextGlobalKey.currentState;
    if (keyCurrentState == null) return;

    final regex = RegExp(inputText.trim(), caseSensitive: false);
    final matches = regex.allMatches(keyCurrentState.widget.text.toLowerCase());
    final textSpans = highlightSearchedText(keyCurrentState, regex, matches);
    keyCurrentState.applyHighlightedText(textSpans.isEmpty
        ? initTextSpans(keyCurrentState.widget.text)
        : textSpans);
    if (textSpans.isNotEmpty) scrollToWord(matches);
  }

  static List<TextSpan> highlightSearchedText(
      HighlightedTextScrollableState currentState,
      RegExp regex,
      Iterable<RegExpMatch> matches) {
    if (matches.isEmpty) return [];

    List<TextSpan> spans = [];
    List<String> parts = currentState.widget.text.split(regex);
    for (int i = 0; i < parts.length; i++) {
      spans.add(TextSpan(
        text: parts[i],
        style: currentState.widget.unHighlightedTextStyle,
      ));
      if (i < parts.length - 1) {
        spans.add(TextSpan(
          text: regex.stringMatch(currentState.widget.text),
          style: currentState.widget.highlightedTextStyle,
        ));
      }
    }
    return spans;
  }

  static void scrollToWord(Iterable<Match> matches) {
    final currentState = TextScrollHighlightHelper.currentState;
    if (currentState == null) return;

    final textPainter = _getTextPainter(currentState);
    final numberOfCharactersInLine =
        _calculateNumberOfCharactersByScreenWidth(textPainter);
    final lineNumber =
        ((matches.first.end / numberOfCharactersInLine) + 0.5).floor();
    final offset = ((lineNumber - 3) * textPainter.height);
    currentState.scrollController.animateTo(
      offset,
      duration: currentState.widget.durationOfScroll,
      curve: currentState.widget.animationCurveOfScroll,
    );
  }

  static TextPainter _getTextPainter(
      HighlightedTextScrollableState currentState) {
    return TextPainter(
      text: TextSpan(
          text: 'a', style: currentState.widget.unHighlightedTextStyle),
      textDirection: TextDirection.ltr,
    )..layout();
  }

  static int _calculateNumberOfCharactersByScreenWidth(
      TextPainter textPainter) {
    final currentState = TextScrollHighlightHelper.currentState;
    if (currentState == null) return 0;

    final screenWidth = MediaQuery.of(currentState.context).size.width -
        currentState.widget.horizontalPadding * 2;
    return ((screenWidth / textPainter.width) + 0.5).floor() +
        _getWhiteSpaceNumber(currentState);
  }

  static int _getWhiteSpaceNumber(HighlightedTextScrollableState currentState) {
    return 120 ~/ currentState.widget.unHighlightedTextStyle.fontSize!;
  }
}
