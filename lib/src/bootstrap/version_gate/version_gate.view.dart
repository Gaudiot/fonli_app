import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fonli_app/assets/svg_assets.dart';
import 'package:fonli_app/core/components/base_view.dart';
import 'package:fonli_app/core/design/colors.dart';
import 'package:fonli_app/l10n/output/app_localizations.dart';
import 'package:fonli_app/src/bootstrap/version_gate/version_gate.viewcontroller.dart';
import 'package:fonli_app/src/bootstrap/version_gate/version_gate.viewmodel.dart';

class VersionGateView extends StatelessWidget {
  final VersionGateViewController viewController;

  const VersionGateView({super.key, required this.viewController});

  @override
  Widget build(BuildContext context) {
    return FView<VersionGateViewModel, VersionGateViewController>(
      viewController: viewController,
      builder: (context, data) {
        return ColoredBox(
          color: FColors.primary,
          child: Center(
            child: Column(
              mainAxisSize: .min,
              children: [
                SvgPicture.asset(SvgAssets.fonliLogo, height: 200, width: 200),
                SizedBox(
                  child: Text(
                    AppLocalizations.of(context).bootstrap__version_gate,
                    textAlign: .center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
