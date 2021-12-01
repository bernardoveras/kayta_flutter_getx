import 'package:get/get.dart';
import 'package:kayta_flutter/Presentation/ViewModels/Comuns/BaseListViewModel.dart';
import 'package:kayta_flutter/ServiceAgents/Comuns/IServiceAgent.dart';
import 'package:kayta_flutter/Shared/Services/NetworkService/INetworkService.dart';
import 'package:kayta_flutter/Shared/Utils/ViewState.dart';
import 'package:kayta_flutter_getx/kayta_flutter_getx.dart';

abstract class GetXListViewModel<TServiceAgent extends IServiceAgent, TModel> extends BaseListViewModel<TServiceAgent, TModel> {
  @override
  TServiceAgent get serviceAgent => Get.find<TServiceAgent>();

  @override
  INetworkService get networkService => Get.find<INetworkService>();

  @override
  IViewState<List<TModel>> get state => ViewState<List<TModel>>();

}
