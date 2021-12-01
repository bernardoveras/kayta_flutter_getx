import 'package:get/get.dart';
import 'package:kayta_flutter/ServiceAgents/Login/ILoginServiceAgent.dart';
import 'package:kayta_flutter/ServiceAgents/Login/LoginServiceAgent.dart';
import 'package:kayta_flutter/Shared/Configuracoes.dart';
import '../../Presentation/ViewModels/Login/LoginViewModel.dart';

class LoginIoc extends Bindings {
  LoginIoc({this.resource = 'seguranca/controleacesso/usuarios/autenticar'});
  
  final String resource;

  @override
  void dependencies() {
    Get.lazyPut<ILoginServiceAgent>(
      () => LoginServiceAgent(
        httpService: Get.find(),
        ambienteDoServidor: Configuracoes.ambienteDoServidor,
        resource: resource,
      ),
    );
    Get.lazyPut(() => LoginViewModel(serviceAgent: Get.find(), localStorage: Get.find(), networkService: Get.find()));
  }
}
