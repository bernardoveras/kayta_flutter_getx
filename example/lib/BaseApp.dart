import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kayta_flutter/Shared/Theme/Theme.dart';
import 'Routes.dart';

class BaseApp extends StatelessWidget {
  final String initialRoute;
  const BaseApp({required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411, 820),
      builder: () {
        return GetMaterialApp(
          title: 'NOMEDOAPP',
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          getPages: Routes.routes,
          defaultTransition: Transition.cupertino,
          theme: VvsTheme.light,
          themeMode: ThemeMode.light,
          builder: (context, child) => GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            behavior: HitTestBehavior.opaque,
            child: child,
          ),
        );
      },
    );
  }
}
