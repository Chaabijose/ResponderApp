import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app.dart';
import '../helper/auth_helper.dart';
import '../helper/flash_helper.dart';
import '../navigation/app_routes.dart';
import '../theme/app_colors.dart';
import 'base_repository.dart';
import 'mixin_overlays.dart';

abstract class BaseController<R extends BaseRepository> extends GetxController
    with Overlays {
  /// Constructor **************************************************************
  final String tag = Get.currentRoute + kNumOfNav.toString();

  ///Data & Observables ********************************************************
  var loading = false.obs;
  bool get globalRepository => false;

  /// inject repo
  R? get repository;

  void injectRepository() {}

  /// U need to inject a repo instance if not coming from a root , Bindings()

  // add all listeners to dispose them
  final List<StreamSubscription?> _disposableList = [];

  ///Matches on page creates
  @override
  void onInit() {
    injectRepository();
    onCreate();
    super.onInit();
  }

  ///Matches on page resume
  @override
  void onReady() {
    _observeError();
    onResume();
    super.onReady();
  }

  @override
  void dispose() {
    repository?.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    onDestroy();
    for (StreamSubscription? subscription in _disposableList) {
      subscription?.cancel();
    }
    _deleteRepository();
    super.onClose();
  }

  void _deleteRepository() {
    loading.close();
    if (!globalRepository && GetInstance().isRegistered<R>(tag: tag)) {
      GetInstance().delete<R>(tag: tag);
    }
  }

  //observe error
  void _observeError() {
    var subscription = repository?.errorObservable.stream.listen((event) {
      showErrorMessage(event.message);
    });
    _disposableList.add(subscription);
  }

  /// Messages
  void showErrorMessage(String? msg) {
    show(msg!, kRed);
  }

  void showSuccessMessage(String msg) {
    show(msg, kGreen);
  }

  void showMessage(String msg) {
    show(msg, kWarning);
  }

  void show(String msg, Color color) {
    FlashHelper.showTopFlash(msg, bckColor: color);
  }

  Future<void> delay()async{
   await Future.delayed(const Duration(seconds: 1));
  }

  ///Abstract - instance  methods to do extra work after init
  void onCreate() {}

  void onResume() {}

  void onDestroy() {}

  ///Helper methods ************************************************************
  void addDisposable(StreamSubscription subscription) =>
      _disposableList.add(subscription);

  void closeDisposableAtIndex(int index) {
    _disposableList[index]?.cancel();
    _disposableList.removeAt(index);
  }

  void stopLoading() {
    loading.value = false;
  }

  void hideKeyboard() => FocusScope.of(Get.context!).requestFocus(FocusNode());

  Future<void> doLogout() async {
    await Get.find<AuthHelper>().logout();
    Get.offAllNamed(Routes.auth);
  }

  bool isLoggedIn() =>
      Get.find<AuthHelper>().isLoggedIn();

}
