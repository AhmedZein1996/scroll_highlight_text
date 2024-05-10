## 0.0.1

- Initial release.

## 0.0.2

- Update metadata.

## 0.0.3

- Fix bug related to empty searched text not being handled properly.

## 0.0.4

- Update provided example.

## 0.0.5

- Update metadata.

## 0.0.6

- Refactor code for improved readability and maintainability.

## 0.0.7

- Update provided example.

## 0.0.8

- Update metadata.

## 0.0.9

- Update example.gif.

## 0.1.0 

- Added support for Arabic text.

## 0.1.1

- Update Readme.md.

## 0.1.2

The changes in version 0.1.2 include:

- Updated `HighlightedTextScrollable` to allow passing a search controller to it, eliminating the need for the unnecessary `onChanged` callback to make it self-contained:
  
  Old Code
 ```dart
      SearchBar(
                  hintText: 'Start search',
                  onChanged: (value) {
                    TextScrollHighlight.scrollToHighlightedText(value);
                  },
                ),
```  
  
```dart
        HighlightedTextScrollable(
                text: englishContent,
             ),
```

  New Code
```dart
     SearchBar(
                    hintText: 'Start search',
                    controller: controller,
                  ),
 ```
  
```dart
       HighlightedTextScrollable(
                  text: englishContent, 
                  searchController: controller,),
 ```

- Updated `Readme.md`.

- Updated example usage of the component.

## 0.1.3

- Updated `Readme.md`.

## 0.1.4

- Updated example usage of the component.
