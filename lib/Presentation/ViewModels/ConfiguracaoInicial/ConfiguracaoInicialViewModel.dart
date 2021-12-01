import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluent_validation/models/validation_result.dart';
import 'package:kayta_flutter/Models/ConfiguracaoInicialModel.dart';
import 'package:kayta_flutter/ServiceAgents/ConfiguracaoInicial/IConfiguracaoInicialServiceAgent.dart';
import 'package:kayta_flutter/Shared/Configuracoes.dart';
import 'package:kayta_flutter/Shared/Constants/StoragePath.dart';
import 'package:kayta_flutter/Shared/Errors/Failure.dart';
import 'package:kayta_flutter/Shared/Routes.dart';
import 'package:kayta_flutter/Shared/Services/HttpService/IHttpService.dart';
import 'package:kayta_flutter/Shared/Services/LocalStorage/ILocalStorage.dart';
import 'package:kayta_flutter/Shared/Services/NetworkService/INetworkService.dart';
import 'package:kayta_flutter/Shared/Theme/Colors.dart';
import 'package:kayta_flutter/Shared/Utils/Task.dart';
import 'ConfiguracaoInicialValidator.dart';
import '../GetXViewModel.dart';
import '../../../Shared/Services/DialogService/DialogService.dart';

class ConfiguracaoInicialViewModel extends GetXViewModel {
  ConfiguracaoInicialViewModel({
    required this.serviceAgent,
    required this.localStorage,
    required this.networkService,
  });

  final IConfiguracaoInicialServiceAgent serviceAgent;
  final ILocalStorage localStorage;
  final INetworkService networkService;

  final Rx<ConfiguracaoInicialModel> _configuracaoInicial = Rx<ConfiguracaoInicialModel>(ConfiguracaoInicialModel());
  late ConfiguracaoInicialValidator validator;

  late FocusNode enderecoDoServidorFocus;
  late FocusNode portaDoServidorFocus;
  late FocusNode ambienteDoServidorFocus;

  final RxInt _etapa = RxInt(1);
  int get etapa => _etapa.value;

  String get enderecoDoServidor => _configuracaoInicial.value.enderecoDoServidor;
  set enderecoDoServidor(String value) => updateConfiguracaoInicial((val) => val.enderecoDoServidor = value);
  final TextEditingController enderecoDoServidorController = TextEditingController();

  String get portaDoServidor => _configuracaoInicial.value.portaDoServidor;
  set portaDoServidor(String value) => updateConfiguracaoInicial((val) => val.portaDoServidor = value);
  final TextEditingController portaDoServidorController = TextEditingController();

  String get ambienteDoServidor => _configuracaoInicial.value.ambienteDoServidor;
  set ambienteDoServidor(String value) => updateConfiguracaoInicial((val) => val.ambienteDoServidor = value);
  final TextEditingController ambienteDoServidorController = TextEditingController();

  final RxBool _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;

  bool get validar {
    ValidationResult validation = validator.validate(_configuracaoInicial.value);

    if (validation.hasError == true) return false;

    return true;
  }

  void proximaEtapa() async {
    if (validar == true && etapa == 3) {
      await testarConexao();
    }

    if (validar == true && etapa != 3) {
      _etapa.value = etapa + 1;
      validator = ConfiguracaoInicialValidator(etapa);
    }
  }

  void voltarEtapa() {
    if (etapa > 1) {
      _etapa.value = etapa - 1;
      validator = ConfiguracaoInicialValidator(etapa);
    }
  }

  Future<void> testarConexao() async {
    loading = true;
    bool offline = await networkService.isOffline();
    await exec<bool>(
      () => serviceAgent.verificarConexao(_configuracaoInicial.value),
      onSuccess: (result) async {
        await Future.wait([
          localStorage.add(ENDERECO_DO_SERVIDOR, enderecoDoServidor),
          localStorage.add(PORTA_DO_SERVIDOR, portaDoServidor),
          localStorage.add(AMBIENTE_DO_SERVIDOR, ambienteDoServidor),
        ]);

        Configuracoes.fromConfiguracaoInicial(_configuracaoInicial.value);

        Get.reload<IHttpService>();

        Get.offAndToNamed(IRoutes.LOGIN);
      },
      onError: (error) async {
        await dialogService.show(text: 'Ocorreu um erro, verifique o endereço do servidor.');
        ambienteDoServidorFocus.requestFocus();
      },
      onComplete: () => loading = false,
      offline: offline,
    );
  }

  void updateConfiguracaoInicial(void Function(ConfiguracaoInicialModel) fn) {
    _configuracaoInicial.update((val) {
      if (val == null) throw GenericFailure();
      fn.call(val);
    });
  }

  @override
  void onInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    
    enderecoDoServidorFocus = FocusNode();
    portaDoServidorFocus = FocusNode();
    ambienteDoServidorFocus = FocusNode();
    validator = ConfiguracaoInicialValidator(etapa);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: VvsColors.primary,
      statusBarBrightness: Brightness.light,
    ));

    super.onInit();
  }
}
