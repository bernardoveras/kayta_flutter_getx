import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:kayta_flutter/ServiceAgents/ConfiguracaoInicial/ConfiguracaoInicialServiceAgent.dart';
import 'package:kayta_flutter/ServiceAgents/ConfiguracaoInicial/IConfiguracaoInicialServiceAgent.dart';
import 'package:kayta_flutter/Shared/Services/HttpService/HttpService.dart';
import 'package:kayta_flutter/Shared/Services/HttpService/IHttpService.dart';
import '../../Presentation/ViewModels/ConfiguracaoInicial/ConfiguracaoInicialViewModel.dart';

class ConfiguracaoInicialIoc extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IHttpService>(() => HttpService(Client(), Get.find(), baseUrl: ''), tag: 'configuracao_inicial', fenix: true);
    Get.lazyPut<IConfiguracaoInicialServiceAgent>(() => ConfiguracaoInicialServiceAgent(Get.find(tag: 'configuracao_inicial')));
    Get.lazyPut(
      () => ConfiguracaoInicialViewModel(
        serviceAgent: Get.find(),
        localStorage: Get.find(),
        networkService: Get.find(),
      ),
    );
  }
}

