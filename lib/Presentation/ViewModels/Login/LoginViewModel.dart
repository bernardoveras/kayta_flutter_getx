import 'package:get/get.dart';
import 'package:kayta_flutter/Shared/Configuracoes.dart';
import 'package:kayta_flutter/Shared/Constants/StoragePath.dart';
import 'package:kayta_flutter/Shared/Routes.dart';
import 'package:kayta_flutter/kayta_flutter.dart';
import '../GetXViewModel.dart';
import '../../../Shared/Services/DialogService/DialogService.dart';

class LoginViewModel extends GetXViewModel {
  LoginViewModel({
    required this.serviceAgent,
    required this.localStorage,
    required this.networkService,
  });

  final ILoginServiceAgent serviceAgent;
  final ILocalStorage localStorage;
  final INetworkService networkService;

  final RxString usuario = ''.obs;
  final RxString senha = ''.obs;
  final RxBool loading = false.obs;

  bool get validar => usuario.value.isNotEmpty && senha.value.isNotEmpty;

  Future<void> entrar([String rotaDepoisDeLogar = IRoutes.HOME]) async {
    loading.value = true;
    bool offline = await networkService.isOffline();

    await exec<UsuarioModel>(
      () => serviceAgent.logar(usuario.value, senha.value),
      onSuccess: (result) async {
        Configuracoes.usuario = result;
        await Future.wait([
          localStorage.add(USER_NOME, result.nome),
          localStorage.add(USER_TOKEN, result.token),
          localStorage.add(USER_SERIAL, result.serial),
        ]);

        Get.offAndToNamed(rotaDepoisDeLogar);
      },
      onError: (error) async {
        await dialogService.show(text: error);
      },
      onComplete: () => loading.value = false,
      offline: offline,
    );
  }
}
