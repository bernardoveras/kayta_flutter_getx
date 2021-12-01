import 'package:get/get.dart';
import 'package:kayta_flutter/Shared/Errors/ErrorState.dart';
import 'package:kayta_flutter/Shared/Utils/ViewState.dart';

// ignore: must_be_immutable
class ViewState<T> extends IViewState<T> {
  Rxn<T> _value = Rxn<T>();
  RxBool _loading = true.obs;
  Rxn<ErrorState> _error = Rxn<ErrorState>();

  ViewState();
  ViewState.loading(this._loading);
  ViewState.value(this._value);
  ViewState.error(this._error);

  @override
  ErrorState? get error => _error.value;

  @override
  bool get loading => _loading.value;

  @override
  T? get value => _value.value;

  @override
  set value(T? value) {
    this._loading.value = false;
    this._error.value = null;
    this._value.value = value;
  }

  @override
  set loading(bool b) {
    this._loading.value = b;
    this._error.value = null;
    this._value.value = null;
  }

  @override
  set error(ErrorState? error) {
    this._error.value = error;
    this._loading.value = false;
    this._value.value = null;
  }
}
