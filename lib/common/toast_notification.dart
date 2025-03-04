import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void errorNotification(BuildContext context, String _mainWarningText, String _warnignExpalin) {
  toastification.show(
    context: context,
    type: ToastificationType.success,
    style: ToastificationStyle.flat,
    autoCloseDuration: const Duration(seconds: 3),
    title: Text(_mainWarningText, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.015)),
    // you can also use RichText widget for title and description parameters
    description: RichText(
      text: TextSpan(text: _warnignExpalin),
    ),
    alignment: Alignment.topRight,
    direction: TextDirection.ltr,
    animationDuration: const Duration(milliseconds: 300),
    animationBuilder: (context, animation, alignment, child) {
      return FadeTransition(opacity: animation, child: child);
    },
    icon: const Icon(Icons.error_outline),
    showIcon: true,
    // show or hide the icon
    primaryColor: Colors.red,
    backgroundColor: Colors.black,
    foregroundColor: Colors.red,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
    showProgressBar: true,
    closeButton: ToastCloseButton(
      showType: CloseButtonShowType.onHover,
    ),
  );
}

void successNotification(BuildContext context, String mainSuccessText, String successExplain) {
  toastification.show(
    context: context,
    type: ToastificationType.success,
    style: ToastificationStyle.flat,
    autoCloseDuration: const Duration(seconds: 3),
    title: Text(mainSuccessText, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.015)),
    // you can also use RichText widget for title and description parameters
    description: RichText(
      text: TextSpan(text: successExplain),
    ),
    alignment: Alignment.topRight,
    direction: TextDirection.ltr,
    animationDuration: const Duration(milliseconds: 300),
    animationBuilder: (context, animation, alignment, child) {
      return FadeTransition(opacity: animation, child: child);
    },
    icon: const Icon(Icons.check_circle_outline),
    showIcon: true,
    // show or hide the icon
    primaryColor: Colors.blue,
    backgroundColor: Colors.black,
    foregroundColor: Colors.blue,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
    showProgressBar: true,
    closeButton: ToastCloseButton(
      showType: CloseButtonShowType.onHover,
    ),
  );
}