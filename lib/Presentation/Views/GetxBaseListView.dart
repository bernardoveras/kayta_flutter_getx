import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kayta_flutter/Presentation/ViewModels/Comuns/BaseListViewModel.dart';
import 'package:kayta_flutter/Presentation/Views/Comuns/Componentes/DefaultEmptyListComponent.dart';
import 'package:kayta_flutter/Presentation/Views/Comuns/Componentes/DefaultOnErrorComponent.dart';
import 'package:kayta_flutter/Presentation/Views/Comuns/Componentes/DefaultOnLoadingComponent.dart';
import 'package:kayta_flutter/Shared/Theme/Colors.dart';
import 'package:kayta_flutter/Shared/Extensions/ScreenUtilExtension.dart';

// ignore: must_be_immutable
abstract class GetxBaseListView<TViewModel extends BaseListViewModel, TModel> extends StatelessWidget {
  /// ViewModel correspondente ao tipo genérico passado no `BaseListView<TViewModel>`
  final TViewModel viewModel = Get.find<TViewModel>();

  /// Quando a `lista for carregada`, este é o componente dos itens da lista.
  /// Você é obrigado a retornar um Widget.
  Widget itemBuilder(TModel model, int index);

  /// Quando `ocorrer um erro`, este é o componente que aparecerá na tela.
  /// Você não é obrigado a retornar um Widget pois já tem um padrão.
  Widget onError(String error) => DefaultOnErrorComponent(error: error);

  /// Enquanto a `lista estiver carregando`, este é o componente que aparecerá na tela.
  /// Você não é obrigado a retornar um Widget pois já tem um padrão.
  Widget onLoading() => DefaultOnLoadingComponent();

  /// Enquanto a `lista for vazia`, este é o componente que aparecerá na tela.
  /// Você não é obrigado a retornar um Widget pois já tem um padrão.
  Widget onEmpty() => DefaultEmptyListComponent();

  PreferredSizeWidget? _appBar;
  void adicionarAppBar(PreferredSizeWidget appBar) => _appBar = appBar;

  Widget? _floatingActionButton;
  void adicionarFloatingActionButton(Widget fab) => _floatingActionButton = fab;

  Widget? _bottomSheet;
  void adicionarBottomSheet(Widget bottomSheet) => _bottomSheet = bottomSheet;

  Color _backgroundColor = VvsColors.background;
  void adicionarBackgroundColor(Color color) => _backgroundColor = color;

  CrossAxisAlignment _crossAxisAlignment = CrossAxisAlignment.center;
  void adicionarCrossAxisAlignment(CrossAxisAlignment alignment) => _crossAxisAlignment = alignment;

  MainAxisAlignment _mainAxisAlignment = MainAxisAlignment.start;
  void adicionarMainAxisAlignment(MainAxisAlignment alignment) => _mainAxisAlignment = alignment;

  ScrollPhysics _listPhysics = BouncingScrollPhysics();
  void adicionarListPhysics(ScrollPhysics physics) => _listPhysics = physics;

  EdgeInsetsGeometry _listPadding = EdgeInsets.all(24.height);
  void adicionarListPadding(EdgeInsetsGeometry padding) => _listPadding = padding;

  List<Widget> _componentes = <Widget>[];
  void adicionarComponente(List<Widget> componentes) => _componentes.addAll(componentes);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: _appBar,
        floatingActionButton: _floatingActionButton,
        bottomSheet: _bottomSheet,
        backgroundColor: _backgroundColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: _crossAxisAlignment,
            mainAxisAlignment: _mainAxisAlignment,
            children: [
              if (viewModel.state.error != null) ...{
                onError(viewModel.state.error!.mensagem),
              } else if (viewModel.state.loading) ...{
                onLoading(),
              } else if (viewModel.state.value?.isEmpty == true) ...{
                onEmpty(),
              } else ...{
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: _listPhysics,
                    padding: _listPadding,
                    itemCount: viewModel.state.value?.length,
                    itemBuilder: (context, index) => itemBuilder(viewModel.state.value?[index], index),
                  ),
                ),
              },
              for (var componente in _componentes) ...{
                componente,
              }
            ],
          ),
        ),
      ),
    );
  }
}
