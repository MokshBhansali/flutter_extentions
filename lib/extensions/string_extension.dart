import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flt_extentions/extensions/extension.dart';
import 'package:flt_extentions/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:mime/mime.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:string_validator/string_validator.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:video_compress/video_compress.dart';
import 'package:http_parser/src/media_type.dart';

import '../utils/check_link.dart';
import '../config/colors.dart';
import '../utils/hashtag_linker.dart';
import '../utils/mention_linker.dart';
import '../regex/regex.dart';
import '../theme/app_theme.dart';

bool isDark = false;

extension SafetyExtension on String? {
  bool get neann => this != null && this!.isNotEmpty;
}

extension StringExtensions on String {
  String get hostName {
    final uri = Uri.parse(this);
    final hostname =
        uri.host.split('.')[uri.host.split('.').length - 2].capitalize();
    final lastWord = uri.host.split('.')[uri.host.split('.').length - 1];
    return '$hostname.$lastWord';
  }

  String get getLanguageCode {
    switch (this) {
      case 'english':
        return 'en';

      case 'arabic':
        return 'ar';

      case 'french':
        return 'fr';

      case 'german':
        return 'de';

      case 'italian':
        return 'it';

      case 'russian':
        return 'ru';

      case 'portuguese':
        return 'pt';

      case 'spanish':
        return 'es';

      case 'turkish':
        return 'tr';

      case 'dutch':
        return 'nl';

      case 'ukraine':
        return 'uk';

      default:
        return 'en';
    }
  }

  String get makeValidUrl {
    if (!this.contains('https')) {
      return "https://github.com/MokshBhansali/$this";
    }
    return this;
  }

  Future<MultipartFile> toMultiPart() async {
    final mimeTypeData =
        lookupMimeType(this, headerBytes: [0xFF, 0xD8])!.split('/');
    final multipartFile = await MultipartFile.fromFile(this,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    return multipartFile;
  }

  bool get isValidYoutubeOrNot =>
      (CheckLink.isYoutubeLink(this) && CheckLink.isValidYoutubeLink(this)) ||
      !CheckLink.isYoutubeLink(this);

  List<String> extractAllLinks() {
    final urlRegExp = urlPattern2;
    final urlMatches = urlRegExp.allMatches(this);
    List<String> urls = urlMatches
        .map((urlMatch) => substring(urlMatch.start, urlMatch.end))
        .toList();
    urls.removeWhere((url) => !isURL(url));
    return urls;
  }

  bool get isValidEmail {
    final emailRegExp = emailRegexp;
    if (isEmpty) {
      return false;
    } else {
      return emailRegExp.hasMatch(this);
    }
  }

  bool get isValidUrl {
    return urlPattern.hasMatch(this);
  }

  Future<MediaInfo?> get compressVideo async =>
      await VideoCompress.compressVideo(
        this,
        quality: VideoQuality.DefaultQuality,
        includeAudio: true,
        deleteOrigin: false, // It's false by default
      );

  Future<File> compressImage() async {
    final Directory tempDir = await getTemporaryDirectory();
    final file = File(this);
    // unsupported compressed file
    if (getFormatType(file.path) == null) return file;
    final result = await (FlutterImageCompress.compressAndGetFile(
        file.path, File(tempDir.path + this).path,
        quality: 60, format: getFormatType(file.path)!));

    return File(result!.path);
  }

  CompressFormat? getFormatType(String name) {
    if (name.endsWith(".jpg") || name.endsWith(".jpeg")) {
      return CompressFormat.jpeg;
    } else if (name.endsWith(".png")) {
      return CompressFormat.png;
    } else if (name.endsWith(".heic")) {
      return CompressFormat.heic;
    } else if (name.endsWith(".webp")) {
      return CompressFormat.webp;
    }
    return null;
  }
}

extension StringExtension on String {
  String capitalize() => '${this[0].toUpperCase()}${substring(1)}';

  String capitalizedStringLetters() {
    try {
      String temp = '';
      split(' ').forEach((s) {
        temp += '${s[0].toUpperCase()}${s.substring(1)} ';
      });
      return temp;
    } catch (e) {
      return '${this[0].toUpperCase()}${substring(1)}';
    }
  }

  bool get isValidPass {
    if (isEmpty) {
      return false;
    } else {
      return length > 7;
    }
  }

  Text get toText => Text(
        parseHtmlString(this),
        style: const TextStyle(),
      );

  Text toHeadLine6({
    num fontSize = AppFontSize.headLine6,
    FontWeight fontWeight = FontWeight.w400,
    Color color = AppColors.textColor,
  }) =>
      Text(
        parseHtmlString(this),
        style: AppTheme.headline6.copyWith(
          fontSize: fontSize.toSp as double?,
          color: color,
          fontWeight: fontWeight,
          fontFamily: "Poppins",
        ),
        textAlign: TextAlign.start,
      );

  Text toHeadLine5(
          {num fontSize = AppFontSize.headLine5,
          Color color = AppColors.textColor}) =>
      Text(
        parseHtmlString(this),
        style: AppTheme.headline5
            .copyWith(fontSize: fontSize.toSp as double?, color: color),
      );

  Text toHeadLine4(
          {num fontSize = AppFontSize.headLine4,
          Color color = AppColors.textColor}) =>
      Text(
        parseHtmlString(this),
        style: AppTheme.headline4
            .copyWith(fontSize: fontSize.toSp as double?, color: color),
      );

  Text toHeadLine3(
          {num fontSize = AppFontSize.headLine3,
          Color color = AppColors.textColor}) =>
      Text(
        parseHtmlString(this),
        style: AppTheme.headline3
            .copyWith(fontSize: fontSize.toSp as double?, color: color),
      );

  Text toHeadLine2(
          {num fontSize = AppFontSize.headLine2,
          Color color = AppColors.textColor}) =>
      Text(
        parseHtmlString(this),
        style: AppTheme.headline2
            .copyWith(fontSize: fontSize.toSp as double?, color: color),
      );

  Text toHeadLine1(
          {num fontSize = AppFontSize.headLine1,
          Color color = AppColors.textColor}) =>
      Text(
        parseHtmlString(this),
        style: AppTheme.headline1
            .copyWith(fontSize: fontSize.toSp as double?, color: color),
      );

  Text toBody1(
          {num fontSize = AppFontSize.bodyText1,
          Color color = AppColors.textColor}) =>
      Text(
        parseHtmlString(this),
        style: AppTheme.bodyText1
            .copyWith(fontSize: fontSize.toSp as double?, color: color),
      );

  Text toBody2({
    int? maxLines,
    num fontSize = AppFontSize.bodyText2,
    FontWeight fontWeight = FontWeight.w400,
    Color? color = AppColors.textColor,
    String fontFamily1 = "",
  }) =>
      Text(
        parseHtmlString(this),
        maxLines: maxLines,
        style: AppTheme.bodyText2.copyWith(
            fontSize: fontSize.toSp as double?,
            color: color,
            fontWeight: fontWeight,
            fontFamily: fontFamily1),
      );

  Widget toSubTitle1(
    void Function(String) launchFunction, {
    num fontSize = AppFontSize.subTitle1,
    FontWeight fontWeight = FontWeight.w400,
    TextAlign align = TextAlign.left,
    ValueChanged<String>? onTapHashtag,
    ValueChanged<String>? onTapMention,
    Color? color,
    String fontFamily1 = "Poppins",
    TextOverflow? overflow,
  }) =>
      Linkify(
        strutStyle: const StrutStyle(
          height: 1.0,
          forceStrutHeight: false,
        ),
        onOpen: (link) async {
          // closing keyboard
          FocusManager.instance.primaryFocus!.unfocus();
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          if (await canLaunchUrlString(link.url)) {
            launchFunction(link.url);
          } else if (link.url.contains("#")) {
            onTapHashtag!.call(link.text.replaceAll("#", ""));
          } else if (link.url.contains('@')) {
            onTapMention!.call(link.text.split("@")[1]);
          } else {
            throw 'Could not launch $link';
          }
        },
        linkifiers: const [
          HashTagLinker(),
          UrlLinkifier(),
          EmailLinkifier(),
          MentionLinker()
        ],
        overflow: overflow ?? TextOverflow.clip,
        text: parseHtmlString(this),
        style: AppTheme.subTitle1.copyWith(
            fontSize: fontSize.toSp as double?,
            // fontSize: fontSize.toSp,
            color: color ?? (isDark ? Colors.white : AppColors.textColor),
            fontWeight: fontWeight,
            fontFamily: fontFamily1),
        linkStyle: const TextStyle(
            color: AppColors.colorPrimary, decoration: TextDecoration.none),
      );

  Text toSubTitle2({
    num fontSize = AppFontSize.subTitle2,
    FontWeight fontWeight = FontWeight.w500,
    TextAlign? align,
    int? maxLines,
    Color? color,
    String fontFamily1 = "",
  }) =>
      Text(
        parseHtmlString(this),
        textAlign: align,
        maxLines: maxLines,
        style: AppTheme.subTitle2.copyWith(
            fontSize: fontSize.toSp as double?,
            color: color ?? (isDark ? Colors.white : AppColors.textColor),
            fontWeight: fontWeight,
            fontFamily: 'Poppins'),
      );

  Text toButton(
          {num fontSize = AppFontSize.button,
          FontWeight fontWeight = FontWeight.w500,
          Color color = AppColors.textColor}) =>
      Text(
        parseHtmlString(this),
        style: AppTheme.button.copyWith(
            fontSize: fontSize.toSp as double?,
            color: color,
            fontWeight: fontWeight),
      );

  Linkify toCaption(
          {num fontSize = AppFontSize.caption,
          int? maxLines,
          TextAlign textAlign = TextAlign.start,
          FontWeight fontWeight = FontWeight.w400,
          TextOverflow textOverflow = TextOverflow.visible,
          Color? color,
          Color linkColor = AppColors.colorPrimary}) =>
      Linkify(
        onOpen: (link) async {
          if (await canLaunchUrlString(link.url)) {
            await launchUrlString(link.url);
          } else {
            throw 'Could not launch $link';
          }
        },
        textAlign: textAlign,
        text: parseHtmlString(this),
        maxLines: maxLines,
        style: AppTheme.caption.copyWith(
          fontSize: fontSize.toSp as double?,
          color: color ?? (isDark ? Colors.white : Colors.black),
          fontWeight: fontWeight,
          fontFamily: "Poppins",
        ),
        linkStyle: TextStyle(
          color: linkColor,
          fontFamily: "Poppins",
          overflow: textOverflow,
        ),
      );

  SvgPicture toSvg({num height = 15, num width = 15, Color? color}) =>
      SvgPicture.asset(this,
          color: color,
          width: width.toWidth as double?,
          height: width.toHeight as double?,
          semanticsLabel: 'A red up arrow');

  Image toAssetImage({double height = 50, double width = 50}) =>
      Image.asset(this,
          height: height.toHeight as double?, width: width.toWidth as double?);

  Widget toRoundNetworkImage({num radius = 10, num borderRadius = 60.0}) =>
      isValidUrl
          ? ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius.toDouble()),
              child: CircleAvatar(
                radius: radius.toHeight + (radius.toWidth as double),
                backgroundColor: Colors.transparent,
                // backgroundImage:Image(),
                child: CachedNetworkImage(
                  imageUrl: this,
                ),
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius.toDouble()),
              child: CircleAvatar(
                radius: radius.toHeight + (radius.toWidth as double),
                backgroundColor: Colors.transparent,
                // backgroundImage:Image(),
                child: Image.file(
                  File(
                    this,
                  ),
                  fit: BoxFit.cover,
                  width: 100,
                ),
              ),
            );

  Widget toNetWorkOrLocalImage(
          {num height = 50, num width = 50, num borderRadius = 20}) =>
      isValidUrl
          ? ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius.toDouble()),
              child: CachedNetworkImage(
                imageUrl: this,
                height: height.toHeight as double?,
                width: width.toWidth as double?,
                fit: BoxFit.cover,
              ),
            )
          : Image.file(
              File(this),
              fit: BoxFit.cover,
              width: width.toWidth as double?,
              height: height.toHeight as double?,
            );

  Widget toTab() => Tab(
        text: this,
      ).toContainer(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey, width: 0.2))));

  bool get toBool {
    final value = int.tryParse(this);
    if (value == null || value == 0) return false;
    return true;
  }

  String get parseHtml => parseHtmlString(this);

  bool get isVerifiedUser => this == "1" ? true : false;
}

String parseHtmlString(String data) {
  if (!data.contains('href=')) return data;
  final document = parse(data);
  final hrefs = document
      .getElementsByTagName('a')
      .where((e) =>
          e.attributes.containsKey('href') &&
          e.attributes['target'] != null &&
          !e.text.startsWith('@'))
      .map((e) => e.attributes['href'])
      .toList();
  final oldLinks = document
      .getElementsByTagName('a')
      .where((e) =>
          e.attributes.containsKey('href') && e.attributes['target'] != null)
      .toList();
  String newData = data;
  for (int i = 0; i < hrefs.length; i++) {
    newData = newData.replaceAll(oldLinks[i].text, hrefs[i]!);
  }
  final newDocument = parse(newData);
  final String parsedString =
      parse(newDocument.body!.text).documentElement!.text;
  return parsedString;
}
