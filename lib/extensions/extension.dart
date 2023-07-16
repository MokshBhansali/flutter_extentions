import 'package:dio/dio.dart';
import 'package:flt_extentions/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../config/stream_validators.dart';
import 'string_extension.dart';
import '../theme/app_theme.dart';

extension ScreenUtilExtension on num {
  num get toSp => ScreenUtil().setSp(this);

  num get toWidth => ScreenUtil().setWidth(this);

  num get toHeight => ScreenUtil().setHeight(this);

  num get toHorizontal => ScreenUtil().setWidth(this);

  num get toVertical => ScreenUtil().setHeight(this);

  SizedBox get toSizedBox => SizedBox(
        height: h,
        width: w,
      );

  SizedBox get toSizedBoxVertical => SizedBox(height: h);

  SizedBox get toSizedBoxHorizontal => SizedBox(width: w);

  Widget toContainer({required num height, required num width, Color? color}) =>
      Container(
        color: color,
        width: width.w,
        height: height.h,
      );
  RoundedRectangleBorder get toRoundRectTop => RoundedRectangleBorder(
      borderRadius:
          BorderRadius.vertical(top: Radius.circular(this as double)));
}

extension ExtensionContainer on Container {
  SizedBox get autoScale => SizedBox(
        width: constraints!.maxWidth.w,
        height: constraints!.maxHeight.h,
      );
}

extension ListWidgetExtension on List<Widget?> {
  Column toColumn(
          {MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
          CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
          MainAxisSize mainAxisSize = MainAxisSize.min}) =>
      Column(
        mainAxisSize: mainAxisSize,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: this as List<Widget>,
      );

  ListView toListView({
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.min,
  }) =>
      ListView(
        children: this as List<Widget>,
      );

  ListView toListViewSeparated({required int itemCount, Widget? child}) =>
      ListView.separated(
        itemBuilder: (BuildContext context, int index) => child!,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: itemCount,
      );

  Row toRow(
          {MainAxisSize mainAxisSize = MainAxisSize.max,
          MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
          CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start}) =>
      Row(
        mainAxisSize: mainAxisSize,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: this as List<Widget>,
      );

  Wrap toWrap() => Wrap(
        spacing: 3,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: this as List<Widget>,
      );
}

extension ColmnExtension on Column {
  Widget makeScrollable({bool disableScroll = false}) => !disableScroll
      ? SingleChildScrollView(
          child: this,
        )
      : this;
}

extension TextFieldExtension on TextField {
  StreamBuilder<T> toStreamBuilder<T>({
    required StreamValidators<T> validators,
    TextInputType? keyboardType,
  }) {
    return StreamBuilder<T>(
      stream: validators.stream,
      builder: (context, snapshot) {
        return TextField(
          keyboardType: keyboardType,
          maxLength: maxLength,
          maxLines: maxLines,
          style: AppTheme.button.copyWith(
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : null,
          ),
          obscureText: validators.obsecureTextBool,
          focusNode: validators.focusNode,
          textInputAction: validators.nextFocusNode == null
              ? TextInputAction.done
              : TextInputAction.next,
          controller: validators.textController,
          decoration: decoration!,
          onChanged: validators.onChange,
          inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
          onSubmitted: (value) {
            onSubmitted!(value);
            if (validators.nextFocusNode != null) {
              FocusScope.of(context).requestFocus(validators.nextFocusNode);
            }
          },
        );
      },
    );
  }

  Widget toPostBuilder<T>({
    required StreamValidators<T> validators,
    VoidCallback? fun,
    bool autofocus = false,
    FocusNode? focusNode,
    int maxLength = 600,
  }) =>
      StreamBuilder<T>(
        stream: validators.stream,
        builder: (context, snapshot) => TextField(
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          maxLength: maxLength,
          autofocus: autofocus,
          maxLines: maxLines,
          style: AppTheme.button.copyWith(
              fontWeight: FontWeight.w500, color: isDark ? Colors.white : null),
          obscureText: validators.obsecureTextBool,
          focusNode: focusNode ?? validators.focusNode,
          controller: validators.textController,
          inputFormatters: [LengthLimitingTextInputFormatter(this.maxLength)],
          decoration:
              decoration!.copyWith(errorText: snapshot.error as String?),
          onChanged: (value) {
            if (fun != null) fun();
            if (validators.text.length < 601) {
              validators.onChange(value);
            } else {
              validators.onChange(value.substring(0, 599)[0]);
            }
          },
          onSubmitted: (value) {
            onSubmitted!(value);
            if (validators.nextFocusNode != null) {
              FocusScope.of(context).requestFocus(validators.nextFocusNode);
            }
          },
        ),
      );
}

extension BoolExtension on bool {
  bool get not => this == false;
}

extension ListStringExtension on List<String> {
  Widget toPopUpMenuButton(
    StringToVoidFunc fun, {
    Widget? icon,
    Color Function(String)? backGroundColor,
    TextStyle? textStyle,
    Widget Function(String)? rowIcon,
  }) =>
      PopupMenuButton<String>(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        icon: icon ??
            const Icon(
              FontAwesomeIcons.ellipsisVertical,
              size: 20,
              color: Colors.grey,
            ),
        onSelected: fun,
        offset: Offset(0, 25.h),
        color: isDark
            ? Colors.black.withOpacity(.9)
            : const Color.fromARGB(255, 243, 243, 243).withOpacity(.96),
        padding: const EdgeInsets.only(left: 10, bottom: 10),
        elevation: 0,
        itemBuilder: (context) {
          List<PopupMenuEntry<String>> menuList = [];
          for (int i = 0; i < length; i++) {
            final String choice = this[i];
            final backgroundcolor = backGroundColor != null
                ? backGroundColor(choice)
                : isDark
                    ? Colors.white
                    : Colors.black;
            menuList.add(
              PopupMenuItem<String>(
                value: choice,
                textStyle: const TextStyle(),
                height: 0,
                child: [
                  choice.toCaption(color: backgroundcolor, fontSize: 13),
                  if (rowIcon != null)
                    Container(
                      child: rowIcon(choice),
                    ),
                ].toRow(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              ),
            );

            if (i < length - 1) menuList.add(const PopupMenuDivider());
          }

          return menuList;
        },
      ).toContainer();
}

typedef StringToVoidFunc = void Function(String?);
typedef IntToVoidFunc = void Function(int);

extension DioExtension on DioException {
  String get handleError {
    String errorDescription = "";
    try {
      switch (type) {
        case DioExceptionType.connectionTimeout:
          errorDescription = "Connection timeout with API server";
          break;
        case DioExceptionType.sendTimeout:
          errorDescription = "Send timeout";
          break;
        case DioExceptionType.receiveTimeout:
          errorDescription = "Receive timeout";
          break;
        case DioExceptionType.badCertificate:
          errorDescription = "${response!.data["error"]["error"][0]}";
          break;
        case DioExceptionType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioExceptionType.badResponse:
          errorDescription = "Bad Response";
          break;
        case DioExceptionType.connectionError:
          errorDescription = "Request failed due to internet connection";
          break;
        case DioExceptionType.unknown:
          errorDescription = "Request failed due to unknown error";
          break;
      }
    } catch (e) {
      errorDescription = "Something went wrong";
    }
    return errorDescription;
  }
}
