import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kayta_flutter/Presentation/Views/Comuns/BaseView.dart';
import 'package:kayta_flutter/Shared/Components/AppBar/BaseAppBar.dart';
import 'package:kayta_flutter/Shared/Components/KaytaBottomSheet.dart';
import 'package:kayta_flutter/Shared/Components/TextField/KaytaUnderlineTextField.dart';
import 'package:kayta_flutter/Shared/Extensions/ScreenUtilExtension.dart';
import '../../ViewModels/ConfiguracaoInicial/ConfiguracaoInicialViewModel.dart';
import 'Componentes/StepComponent.dart';

class ConfiguracaoInicialView extends BaseView<ConfiguracaoInicialViewModel> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Obx(
        () => Scaffold(
          appBar: BaseAppBar(
            title: 'Configuração',
            description: StepComponent(step: viewModel.etapa, lastStep: 3),
            onReturn: () => viewModel.voltarEtapa(),
            showReturnButton: viewModel.etapa >= 2,
          ),
          bottomSheet: KaytaBottomSheet(
            title: "Próximo",
            disabled: !viewModel.validar,
            onTap: () => viewModel.proximaEtapa(),
            loading: viewModel.loading,
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(24.height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (viewModel.etapa == 1) ...{
                  KaytaUnderlineTextField.config(
                    title: 'Informe o endereço do servidor',
                    focusNode: viewModel.enderecoDoServidorFocus,
                    onChanged: (v) => viewModel.enderecoDoServidor = v,
                    controller: viewModel.enderecoDoServidorController,
                    onFieldSubmitted: viewModel.validar == true
                        ? (_) {
                            viewModel.proximaEtapa();
                            viewModel.portaDoServidorFocus.requestFocus();
                          }
                        : null,
                  ),
                } else if (viewModel.etapa == 2) ...{
                  KaytaUnderlineTextField.config(
                    title: 'Informe a porta do servidor',
                    focusNode: viewModel.portaDoServidorFocus,
                    onChanged: (v) => viewModel.portaDoServidor = v,
                    controller: viewModel.portaDoServidorController,
                    onFieldSubmitted: viewModel.validar == true
                        ? (_) {
                            viewModel.proximaEtapa();
                            viewModel.ambienteDoServidorFocus.requestFocus();
                          }
                        : null,
                  ),
                } else if (viewModel.etapa == 3) ...{
                  KaytaUnderlineTextField.config(
                    title: 'Informe o ambiente do servidor',
                    focusNode: viewModel.ambienteDoServidorFocus,
                    onChanged: (v) => viewModel.ambienteDoServidor = v,
                    controller: viewModel.ambienteDoServidorController,
                    onFieldSubmitted: viewModel.validar == true ? (_) => viewModel.proximaEtapa() : null,
                  ),
                }
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  get viewModel => Get.find<ConfiguracaoInicialViewModel>();
}