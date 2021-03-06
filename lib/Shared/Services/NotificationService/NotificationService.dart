import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kayta_flutter/Shared/Services/NotificationService/INotificationService.dart';
import 'package:kayta_flutter/Shared/Theme/Colors.dart';

class NotificationService extends GetxService implements INotificationService {
  @override
  Future<void> show({
    String? title,
    String? message,
    Widget? titleWidget,
    Widget? messageWidget,
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 5),
    Widget? icon,
    void Function()? onTap,
  }) async {
    return Get.rawSnackbar(
      title: title,
      message: message,
      titleText: titleWidget,
      messageText: messageWidget,
      duration: duration,
      backgroundColor: backgroundColor ?? VvsColors.primary,
      icon: icon,
      onTap: (_) => onTap,
    );
  }
}
