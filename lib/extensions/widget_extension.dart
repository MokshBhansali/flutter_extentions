import 'package:flt_extentions/extensions/extension.dart';
import 'package:flt_extentions/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

extension PaddingExtension on Widget {
  Widget toOutlinedBorder(VoidCallback? callback,
          {double borderRadius = 20, Color borderColor = Colors.black}) =>
      OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          side: BorderSide(color: borderColor, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: callback,
        child: toPadding(6),
      );

  Widget toVisibility(bool visibility) => Visibility(
        visible: visibility,
        child: this,
      );

  Widget toSwipeToDelete({required Key key, VoidCallback? onDismissed}) =>
      Dismissible(
        onDismissed: (direction) {
          onDismissed?.call();
        },
        direction: DismissDirection.endToStart,
        key: key,
        background: Container(
          color: Colors.black,
          child: [
            TextButton.icon(
              icon: SvgPicture.asset(
                // TODO:
                "Images.delete",
                color: Colors.white,
                height: 16,
                width: 16,
              ),
              label: "Delete"
                  .toCaption(color: Colors.white, fontWeight: FontWeight.bold),
              onPressed: () {},
            ),
          ]
              .toRow(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center)
              .toHorizontalPadding(12),
        ),
        child: this,
      );
  Widget toPadding(num value) => Padding(
        padding: EdgeInsets.symmetric(
            vertical: value.toVertical as double,
            horizontal: value.toHorizontal as double),
        child: this,
      );

  Widget toVerticalPadding(num value) => Padding(
        padding: EdgeInsets.symmetric(vertical: value.toVertical as double),
        child: this,
      );
  Widget toPaddingOnly(
          {double top = 0.0,
          double bottom = 0.0,
          double right = 0.0,
          double left = 0.0}) =>
      Padding(
        padding:
            EdgeInsets.only(top: top, right: right, left: left, bottom: bottom),
      );

  Widget toHorizontalPadding(num value) => Padding(
        padding: EdgeInsets.symmetric(horizontal: value.toHorizontal as double),
        child: this,
      );

  Widget toSymmetricPadding(num horizontal, num vertical) => Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizontal.toHorizontal as double,
            vertical: vertical.toVertical as double),
        child: this,
      );

  Container toContainer(
          {AlignmentGeometry alignment = Alignment.centerLeft,
          double? maxWidth,
          double? height,
          Color? color,
          BoxDecoration? decoration,
          double? width,
          EdgeInsetsGeometry? padding}) =>
      Container(
        padding: padding,
        constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
        alignment: alignment,
        color: color,
        decoration: decoration,
        height: height?.toHeight as double?,
        width: width,
        child: this,
      );

  Expanded toExpanded({int flex = 1}) => Expanded(
        flex: flex,
        child: this,
      );

  Flexible toFlexible({int flex = 1}) => Flexible(
        flex: flex,
        child: this,
      );
  TextButton toFlatButton(VoidCallback callback, {Color? color}) => TextButton(
        style: TextButton.styleFrom(backgroundColor: color),
        onPressed: callback,
        child: this,
      );

  Widget onTapWidget(VoidCallback callback,
          {bool removeFocus = true, VoidCallback? onLongPress}) =>
      InkWell(
        onLongPress: onLongPress,
        onTap: () {
          if (removeFocus) {
            FocusManager.instance.primaryFocus!.unfocus();
          }
          callback.call();
        },
        child: this,
      );

  Widget toIconButton({required VoidCallback onTap}) => IconButton(
        icon: this,
        onPressed: onTap,
      );

  Widget toCenter() => Container(
        alignment: Alignment.center,
        child: this,
      );

  SizedBox toSizedBox({required num height, required num width}) => SizedBox(
        height: height.toHeight as double?,
        width: width.toWidth as double?,
        child: this,
      );

  FadeTransition toFadeAnimation(AnimationController controller) =>
      FadeTransition(
        opacity: Tween(begin: 0.5, end: 1.0).animate(controller),
        child: this,
      );

  SlideTransition toSlideAnimation(AnimationController controller) =>
      SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, -1.0),
          end: const Offset(0.0, 0.0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Curves.linear,
            reverseCurve: Curves.linear,
          ),
        ),
        child: this,
      );

  ScaleTransition toScaleAnimation(AnimationController controller) =>
      ScaleTransition(
        scale: controller,
        child: this,
      );

  Widget get toSafeArea => SafeArea(
        child: this,
      );

  Widget toMaterialButton(VoidCallback callback, {bool enabled = true}) =>
      TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(6),
          backgroundColor:
              enabled ? Colors.black : Colors.black.withOpacity(.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
        ),
        child: this,
        onPressed: () {
          if (enabled) {
            FocusManager.instance.primaryFocus!.unfocus();
            callback.call();
          }
        },
      );

  Widget toSteamVisibility(Stream<bool> stream) => StreamBuilder<bool>(
        initialData: false,
        builder: (c, snapshot) => toVisibility(snapshot.data!),
        stream: stream,
      );
}

extension ContaninerExtension on Container {
  Widget get makeVerticalBorders => Container(
        decoration: BoxDecoration(
            color: color,
            border: const Border(
                top: BorderSide(color: Colors.grey, width: 0.3),
                bottom: BorderSide(color: Colors.grey, width: 0.3))),
        child: this,
      );

  Widget get makeTopBorder => Container(
        alignment: alignment,
        decoration: BoxDecoration(
            color: color,
            border:
                const Border(top: BorderSide(color: Colors.grey, width: 0.2))),
        constraints: constraints,
        child: this,
      );

  Widget get makeBottomBorder => Container(
        alignment: alignment,
        decoration: BoxDecoration(
          color: color,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade300,
              width: .2,
            ),
          ),
        ),
        constraints: constraints,
        child: this,
      );
}

extension DateExtension on DateTime {
  String getCurrentFormattedTime() {
    final DateFormat formatter = DateFormat('d MMM, y').add_jm();
    return formatter.format(this);
  }
}
