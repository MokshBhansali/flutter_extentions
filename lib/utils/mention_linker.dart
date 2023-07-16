import 'dart:io';

import 'package:flutter_linkify/flutter_linkify.dart';

class MentionLinker extends Linkifier {
  const MentionLinker();
  @override
  List<LinkifyElement> parse(
      List<LinkifyElement> elements, LinkifyOptions options) {
    List<LinkifyElement> items = [];
    for (var element in elements) {
      var index = 0;

      if (element.text.contains("@")) {
        element.text.split(" ").forEach((innerText) {
          stdin.readLineSync();
          if (innerText.contains("@")) {
            if (index != 0) {
              items.add(TextElement(" "));
              items.add(LinkableElement(innerText, innerText));
            } else {
              items.add(LinkableElement(innerText, innerText));
            }
          } else {
            items.add(TextElement(" "));
            items.add(TextElement(innerText));
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
