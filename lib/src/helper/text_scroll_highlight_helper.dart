import 'package:flutter/cupertino.dart';

import '../highlighted_text_scrollable.dart';
import '../styling/app_spacing.dart';

class TextScrollHighlight {
  static void scrollToHighlightedText(String inputText) {
    final keyCurrentState = scrollToHighlightedTextGlobalKey.currentState;
    if (keyCurrentState == null) return;

    final regex = RegExp(inputText.trim(), caseSensitive: false);
    final matches = regex.allMatches(keyCurrentState.widget.text.toLowerCase());
    final textSpans = TextScrollHighlightHelper._highlightSearchedText(
        keyCurrentState, regex, matches);
    keyCurrentState.applyHighlightedText(textSpans.isEmpty
        ? TextScrollHighlightHelper._initTextSpans(keyCurrentState.widget.text)
        : textSpans);

    if (textSpans.isNotEmpty) {
      TextScrollHighlightHelper._scrollToWord(matches, textSpans.first.text);
    }
  }
}

class TextScrollHighlightHelper {
  final HighlightedTextScrollableState? _highlightedTextScrollableState;
  static HighlightedTextScrollableState? _currentState;
  TextScrollHighlightHelper(this._highlightedTextScrollableState) {
    _currentState = _highlightedTextScrollableState;
  }

  static List<TextSpan> _initTextSpans(String text) {
    List<String> parts = text.split(' ');
    return parts.map((part) {
      return TextSpan(
        text: '$part ',
        style: _currentState!.widget.unHighlightedTextStyle,
      );
    }).toList();
  }

  static List<TextSpan> _highlightSearchedText(
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

  static void _scrollToWord(
      Iterable<Match> matches, String? textBeforeFirstMatch) {
    if (_currentState == null) return;

    final textPainter = _getTextPainter(_currentState!);
    final numberOfCharactersInLine =
        _calculateNumberOfCharactersByScreenWidth(textPainter);
    final lineNumber =
        ((matches.first.start / numberOfCharactersInLine)).floor();
    final emptyLinesCount =
        _countTextEmptyLines(_currentState!, textBeforeFirstMatch);
    final offset = ((lineNumber + emptyLinesCount - AppSpacing.twoLines) *
            textPainter.height) +
        _currentState!.widget.padding.vertical / 2;
    _currentState!.scrollController.animateTo(
      offset,
      duration: _currentState!.widget.durationOfScroll,
      curve: _currentState!.widget.animationCurveOfScroll,
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
    if (_currentState == null) return 0;

    final screenWidth = MediaQuery.of(_currentState!.context).size.width -
        _currentState!.widget.padding.horizontal;
    return ((screenWidth / textPainter.width)).floor() +
        _getWhiteSpaceNumber(_currentState!);
  }

  static int _getWhiteSpaceNumber(HighlightedTextScrollableState currentState) {
    return 120 ~/ currentState.widget.unHighlightedTextStyle.fontSize!;
  }

  static int _countTextEmptyLines(HighlightedTextScrollableState currentState,
      String? textBeforeFirstMatch) {
    if (textBeforeFirstMatch == null || textBeforeFirstMatch.isEmpty) return 0;
    final lines = textBeforeFirstMatch.split('\n'); // Split the text into lines
    return lines.where((line) => line.trim().isEmpty).length;
  }
}
