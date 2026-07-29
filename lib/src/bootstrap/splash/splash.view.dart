import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fonli_app/assets/svg_assets.dart';
import 'package:fonli_app/core/components/base_view.dart';
import 'package:fonli_app/core/design/colors.dart';
import 'package:fonli_app/src/bootstrap/splash/splash.viewcontroller.dart';
import 'package:fonli_app/src/bootstrap/splash/splash.viewmodel.dart';

class SplashView extends StatelessWidget {
  final SplashViewController viewController;

  const SplashView({super.key, required this.viewController});

  @override
  Widget build(BuildContext context) {
    return FView<SplashViewModel, SplashViewController>(
      viewController: viewController,
      builder: (context, data) {
        return ColoredBox(
          color: FColors.primary,
          child: Center(
            child: Column(
              mainAxisSize: .min,
              children: [
                SvgPicture.asset(SvgAssets.fonliLogo, height: 200, width: 200),
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }
}
