import 'package:flutter_linkify/flutter_linkify.dart';

class HashTagLinker extends Linkifier {
  const HashTagLinker();
  @override
  List<LinkifyElement> parse(
      List<LinkifyElement> elements, LinkifyOptions options) {
    List<LinkifyElement> items = [];
    // get all items
    for (var element in elements) {
      // check if it's contains hashtags
      if (element.text.contains("#")) {
        // helps to keep the index of current iteration
        var index = 0;

        //  remove spaced from beginning and end
        element.text.trim().split(" ").forEach((innerText) {
          // added linkable text if it's hashtag
          if (innerText.contains("#")) {
            // added space in front of all hashtags
            if (index != 0) {
              // addling space
              items.add(TextElement(" "));
              items.add(LinkableElement(innerText, innerText));
            } else {
              // add item linkable without space
              items.add(LinkableElement(innerText, innerText));
            }
          } else {
            items.add(TextElement("$innerText "));
          }
          index = index + 1;
        });
      } else {
        items.add(element);
      }
    }
    return items;
  }
}
