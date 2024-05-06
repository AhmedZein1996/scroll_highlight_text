# Scroll Highlight Text

Flutter package for highlighting and scrolling through text.

![example.gif](https://github.com/AhmedZein1996/scroll_highlight_text/blob/main/example.gif)

## Usage
To use this package in your Flutter project,
1. add scroll_highlight_text as a dependency in your `pubspec.yaml`
2. Then, import the package in your Dart code:
import 'package:scroll_highlight_text/scroll_highlight_text.dart';

3. simply pass your text to `HighlightedTextScrollable` widget:

```dart
HighlightedTextScrollable(
  text: content,
)

4. To highlight and scroll to specific words within the text, you can use the TextScrollHighlight.scrollToHighlightedText method.

## Example 

Here are small examples that show you how to use the API.

import 'package:flutter/material.dart';
import 'package:scroll_highlight_text/scroll_highlight_text.dart';

const String content =
    """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vulputate auctor augue, vitae accumsan odio cursus a. Integer gravida luctus erat, id congue mi vehicula vel. Morbi at neque felis. In hac habitasse platea dictumst. Cras ultricies eros quis libero fringilla, eget convallis leo placerat. Vestibulum vitae odio sit amet lacus feugiat placerat. Nullam id consequat mauris. Maecenas vestibulum magna in vehicula tempor. Ut id dapibus mi. Donec at nisl risus. Quisque nec tortor sit amet nunc suscipit iaculis. Vivamus bibendum risus non magna gravida rutrum. Nulla facilisi. Sed hendrerit eget enim at eleifend.

Phasellus at purus ac risus lobortis cursus. Vestibulum bibendum auctor massa sit amet blandit. Sed vel tincidunt est. Vivamus tempor diam vel tortor posuere, eget fermentum arcu tempor. Fusce nec eleifend turpis. Nullam auctor convallis fringilla. Sed id erat velit. Integer pretium ex a nisi vehicula, id euismod sem cursus. Mauris congue massa magna, ut rutrum ipsum dictum non. Integer nec libero a velit dapibus aliquam. Proin blandit ultricies nisi, eget auctor urna cursus ac. Vestibulum euismod augue nec ex ultricies, ac vestibulum lacus mattis. Suspendisse commodo metus ut semper laoreet. Duis tincidunt mauris et risus feugiat, non posuere arcu congue. Donec id arcu nec mauris pharetra ultricies nec in justo.

Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Maecenas consequat libero id urna elementum, non viverra elit pharetra. Fusce tempor felis nec velit tincidunt, id feugiat libero ullamcorper. Duis placerat justo vitae felis pharetra, ut cursus dui gravida. Proin id ultrices dui. Vivamus nec nunc urna. Donec commodo euismod tellus, eget maximus sem vehicula sit amet. Fusce placerat rutrum nulla. Nam ac libero ac eros tristique condimentum.

Sed gravida ullamcorper quam ut laoreet. Curabitur gravida leo eget nunc suscipit, ac elementum libero pharetra. Fusce a nisi risus. Proin sollicitudin, ligula ac pretium congue, quam nisi convallis tortor, vel varius nisi ex sed enim. Nullam sem nulla, gravida in ipsum at, consequat auctor leo. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Phasellus efficitur elit a libero aliquet, eget bibendum risus rutrum. Nam eleifend dolor nisl, in sollicitudin orci ultricies in. Aenean eget leo nec nisi fermentum varius.

Suspendisse potenti. Mauris ultricies magna id magna rhoncus, a congue elit luctus. Nulla facilisi. Morbi molestie magna in sapien iaculis condimentum. Maecenas at nisi eros. Aliquam erat volutpat. Curabitur laoreet, justo id dignissim sollicitudin, nisi urna luctus leo, at tempor nunc dolor ut justo. Nam eu rhoncus nulla. Duis vel lacus vitae quam finibus auctor eget ut purus. Nullam euismod, nisi nec varius suscipit, orci odio luctus est, id suscipit tortor nunc in elit. Sed ac ipsum nec erat eleifend consectetur. Nam et lacus vitae urna hendrerit faucibus. In hac habitasse platea dictumst. Sed eu ex nec turpis pellentesque dapibus vel sed risus. Vivamus nec dictum lacus. Sed vitae velit a ex tristique pulvinar.

Phasellus lacinia, purus et sollicitudin faucibus, quam quam vehicula elit, ut dignissim lorem magna vitae purus. Integer non tellus ac dui varius tincidunt. Integer id urna magna. Cras bibendum volutpat felis non scelerisque. Nam condimentum justo ac sapien tincidunt interdum. Nulla facilisi. Aenean tincidunt tortor nisi, nec varius mi rutrum nec. Sed ut commodo ligula. Suspendisse potenti. Sed vel ullamcorper purus. Aliquam vitae viverra nulla. Mauris non ligula non turpis facilisis fringilla.

Duis vel faucibus metus, ac congue mi. Duis quis tellus et orci scelerisque bibendum. Integer bibendum, nunc et posuere vehicula, arcu urna accumsan dui, eget placerat erat enim vitae enim. Curabitur sed orci at arcu laoreet fringilla. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Fusce interdum tincidunt diam a feugiat. Nam quis arcu eros. Vivamus vel orci libero. Aliquam et magna in nisi tincidunt interdum. Sed vitae leo id mi convallis commodo ac et odio. Integer eu erat enim. In at ligula ex. Nam pharetra lectus eu feugiat lobortis. Aliquam at est in magna mollis scelerisque non eget odio. Vivamus vel nisi ac nisi accumsan commodo. Integer semper ex non felis tincidunt, ut lacinia lacus dictum. Vivamus eu nulla ut lacus dictum condimentum vel at leo.

Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Ut scelerisque neque eu lorem hendrerit suscipit. Fusce a vestibulum ligula. Suspendisse sit amet diam sagittis, dapibus purus vel, viverra ligula. Nam vitae quam a nibh tempus vestibulum. Curabitur id nisl nec ipsum facilisis posuere. Aliquam eu consequat magna. Sed dignissim quam ac urna commodo, eget posuere quam commodo. Vivamus vulputate tellus sit amet massa fringilla, sed fermentum ex feugiat. Ut vel sodales dolor. Fusce interdum, justo ac rutrum condimentum, ex urna molestie nulla, eget tempor leo eros ut dolor. Aliquam non lorem vel dui posuere tristique. Ut tincidunt nec ligula nec eleifend. Vivamus efficitur placerat aliquam.

Aenean vel ligula dolor. Mauris""";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SearchBar(
                  hintText: 'Start search',
                  onChanged: (value) {
                    TextScrollHighlight.scrollToHighlightedText(value);
                  },
                ),
              ),
              HighlightedTextScrollable(
                text: content,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


### Additional Information

To learn more about this package and its functionalities, you can visit the [GitHub repository](https://github.com/AhmedZein1996/scroll_highlight_text).

Contributions to the package are welcome! You can contribute by forking the repository, making your changes, and submitting a pull request. For any issues or feature requests, please feel free to open an issue on the GitHub repository.

For more information about using this package or for troubleshooting, you can contact the package authors through the GitHub repository's issue tracker.

### Parameters

- `text`: The text content to be displayed and scrolled through.
- `highlightedTextStyle`: The text style applied to highlighted words or phrases.
- `unHighlightedTextStyle`: The text style applied to the rest of the text.
- `padding`: The padding around the text widget.
- `durationOfScroll`: The duration of the scrolling animation.
- `animationCurveOfScroll`: The animation curve used for scrolling transitions.
