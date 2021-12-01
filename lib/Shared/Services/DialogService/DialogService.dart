import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kayta_flutter/Shared/Components/Modal.dart';
import 'package:kayta_flutter/Shared/Services/DialogService/IDialogService.dart';
import 'package:kayta_flutter/Shared/Extensions/ScreenUtilExtension.dart';
import 'package:kayta_flutter/Shared/Theme/Colors.dart';

class DialogService extends GetxService implements IDialogService {
  @override
  Future<void> show({
    required String text,
    String? confirmText,
    String? cancelText,
    bool showCancelButton = false,
    bool showConfirmButton = true,
    void Function()? onCancel,
    void Function()? onConfirm,
    bool showButtons = true,
    Color? confirmColor,
    Color? cancelColor,
    Color textConfirmColor = Colors.white,
    Color? textCancelColor,
    double? height,
    Widget? widget,
    bool confirmLoading = false,
    bool cancelLoading = false,
  }) async {
    return await Get.bottomSheet(
      Modal(
        text: text,
        confirmText: confirmText ?? 'Confirmar',
        cancelText: cancelText ?? 'Cancelar',
        showCancelButton: showCancelButton,
        showConfirmButton: showConfirmButton,
        onConfirm: onConfirm ?? () => Get.back(),
        onCancel: onCancel ?? () => Get.back(),
        confirmColor: confirmColor,
        cancelColor: cancelColor,
        height: height,
        showButtons: showButtons,
        textCancelColor: textCancelColor,
        textConfirmColor: textConfirmColor,
        widget: widget,
        confirmLoading: confirmLoading,
        cancelLoading: cancelLoading,
      ),
    );
  }

  @override
  Future<void> showLoading({
    bool barrierDismissible = false,
  }) async {
    return await Get.dialog(
      Center(
        child: Container(
          height: 80.height,
          width: 80.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.radius),
          ),
          child: Center(
            child: Container(
              height: 40.height,
              width: 40.width,
              child: CircularProgressIndicator(
                color: VvsColors.primary,
                strokeWidth: 4.width,
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: barrierDismissible,
    );
  }
}

IDialogService get dialogService => Get.find<IDialogService>();
