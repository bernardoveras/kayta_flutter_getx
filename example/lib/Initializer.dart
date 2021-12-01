import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:kayta_flutter/Models/ConfiguracaoInicialModel.dart';
import 'package:kayta_flutter/Models/UsuarioModel.dart';
import 'package:kayta_flutter/Shared/Configuracoes.dart';
import 'package:kayta_flutter/Shared/Constants/StoragePath.dart';
import 'package:kayta_flutter/Shared/Services/DialogService/IDialogService.dart';
import 'package:kayta_flutter/Shared/Services/HttpService/HttpService.dart';
import 'package:kayta_flutter/Shared/Services/HttpService/IHttpService.dart';
import 'package:kayta_flutter/Shared/Services/LocalStorage/ILocalStorage.dart';
import 'package:kayta_flutter/Shared/Services/LocalStorage/SharedPreferencesLocalStorage.dart';
import 'package:kayta_flutter/Shared/Services/NetworkService/INetworkService.dart';
import 'package:kayta_flutter/Shared/Services/NetworkService/NetworkService.dart';
import 'package:kayta_flutter_getx/Shared/Services/DialogService/DialogService.dart';
import 'package:kayta_flutter_getx/Shared/Services/LocalStorage/LocalStorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Routes.dart';

class Initializer {
  static Future<void> init() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();

      await Configuracoes.obterVersaoDoAplicativo();
      
      await iniciarSharedPreferences();

      await carregarConfiguracoes();
      await carregarUsuario();
      
      await configurarOutrosServicos();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<void> iniciarSharedPreferences() async {
    SharedPreferences sharedPreferencesInstance = await SharedPreferences.getInstance();
    Get.lazyPut<ILocalStorage>(() => SharedPreferencesLocalStorage(sharedPreferencesInstance, Routes.contains), fenix: true);
  }

  static Future<void> carregarConfiguracoes() async {
    var enderecoDoServidor = localStorage.get(ENDERECO_DO_SERVIDOR);
    var portaDoServidor = localStorage.get(PORTA_DO_SERVIDOR);
    var ambienteDoServidor = localStorage.get(AMBIENTE_DO_SERVIDOR);

    if (enderecoDoServidor != null && portaDoServidor != null && ambienteDoServidor != null) {
      Configuracoes.fromConfiguracaoInicial(ConfiguracaoInicialModel(
        enderecoDoServidor: enderecoDoServidor as String,
        portaDoServidor: portaDoServidor as String,
        ambienteDoServidor: ambienteDoServidor as String,
      ));
    }
  }

  static Future<void> carregarUsuario() async {
    var nomeDoUsuario = localStorage.get(USER_NOME);
    var tokenDoUsuario = localStorage.get(USER_TOKEN);
    var serialDoUsuario = localStorage.get(USER_SERIAL);

    if (nomeDoUsuario != null && tokenDoUsuario != null && serialDoUsuario != null) {
      Configuracoes.usuario = UsuarioModel(token: tokenDoUsuario as String, serial: serialDoUsuario as String, nome: nomeDoUsuario as String);
    }
  }

  static Future<void> configurarOutrosServicos() async {
    Get.lazyPut<IDialogService>(() => DialogService(), fenix: true);
    Get.lazyPut<INetworkService>(() => NetworkService(Connectivity()), fenix: true);
    Get.lazyPut<IHttpService>(() => HttpService(Client(), Get.find(), baseUrl: Configuracoes.url), fenix: true);
  }
}
