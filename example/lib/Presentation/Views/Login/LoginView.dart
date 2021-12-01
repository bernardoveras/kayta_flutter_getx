import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kayta_flutter/Presentation/Views/Comuns/BaseView.dart';
import 'package:kayta_flutter/Shared/Components/Buttons/KaytaButton.dart';
import 'package:kayta_flutter/Shared/Extensions/ScreenUtilExtension.dart';
import 'package:kayta_flutter_getx/Presentation/ViewModels/Login/LoginViewModel.dart';

class LoginView extends BaseView<LoginViewModel> {
  @override
  LoginViewModel get viewModel => Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.height),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: 'Usuário'),
                onChanged: (v) => viewModel.usuario.value = v,
              ),
              SizedBox(height: 10.height),
              TextFormField(
                decoration: InputDecoration(hintText: 'Senha'),
                onChanged: (v) => viewModel.senha.value = v,
              ),
              SizedBox(height: 24.height),
              Obx(
                () => KaytaButton(
                  title: 'Entrar',
                  onTap: () {
                    viewModel.entrar();
                  },
                  loading: viewModel.loading.value,
                  disabled: !viewModel.validar,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
