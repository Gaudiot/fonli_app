import 'package:flutter/material.dart';
import 'package:fonli_app/core/components/base_view.dart';
import 'package:fonli_app/src/bootstrap/version_gate/version_gate.view.dart';
import 'package:fonli_app/src/bootstrap/version_gate/version_gate.viewcontroller.dart';
import 'package:fonli_app/src/bootstrap/version_gate/version_gate.viewmodel.dart';

class VersionGateBuilder extends FViewBuilder {
  @override
  Widget build() {
    final viewModel = VersionGateViewModel();
    final viewController = VersionGateViewController(viewModel: viewModel);
    return VersionGateView(viewController: viewController);
  }
}
