import 'package:flutter/material.dart';
import 'package:fonli_app/core/components/base_view.dart';
import 'package:fonli_app/src/bootstrap/splash/splash.view.dart';
import 'package:fonli_app/src/bootstrap/splash/splash.viewcontroller.dart';
import 'package:fonli_app/src/bootstrap/splash/splash.viewmodel.dart';

class SplashBuilder extends FViewBuilder {
  @override
  Widget build() {
    final viewModel = SplashViewModel();
    final viewController = SplashViewController(viewModel: viewModel);
    return SplashView(viewController: viewController);
  }
}
