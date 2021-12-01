import 'package:get/get.dart';
import 'package:kayta_flutter_getx/IoC/ConfiguracaoInicial/ConfiguracaoInicialIoc.dart';
import 'package:kayta_flutter_getx/IoC/Login/LoginIoc.dart';
import 'package:kayta_flutter_getx/Presentation/Views/ConfiguracaoInicial/ConfiguracaoInicialView.dart';

import 'Presentation/Views/Login/LoginView.dart';

class Routes {
  static const CONFIGURACAO_INICIAL = '/configuracao';
  static const LOGIN = '/login';

  static String get initialRoute => CONFIGURACAO_INICIAL;

  static List<GetPage> get routes => [
        GetPage(
          name: Routes.CONFIGURACAO_INICIAL,
          page: () => ConfiguracaoInicialView(),
          binding: ConfiguracaoInicialIoc(),
        ),
        GetPage(
          name: Routes.LOGIN,
          page: () => LoginView(),
          binding: LoginIoc(),
        ),
      ];

  static bool contains(String route) {
    if (route == CONFIGURACAO_INICIAL) return true;
    if (route == LOGIN) return true;

    return false;
  }
}
