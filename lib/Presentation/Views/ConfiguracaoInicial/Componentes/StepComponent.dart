import 'package:flutter/material.dart';
import 'package:kayta_flutter/Shared/Theme/Colors.dart';
import 'package:kayta_flutter/Shared/Extensions/ScreenUtilExtension.dart';

class StepComponent extends StatelessWidget {
  final int step;
  final int lastStep;

  const StepComponent({Key? key, required this.step, required this.lastStep}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: 'Passo ',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        TextSpan(
          text: '$step',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: VvsColors.secondary,
          ),
        ),
        TextSpan(
          text: ' de $lastStep',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ]),
    );
  }
}
