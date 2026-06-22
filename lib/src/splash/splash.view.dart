import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fonli_app/assets/svg_assets.dart';
import 'package:fonli_app/core/design/colors.dart';
import 'package:fonli_app/src/splash/splash.viewcontroller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  final SplashViewController viewController = SplashViewController();
  late final AnimationController _controller;
  late final Animation<double> _sizeAnimation;
  static const double _logoSize = 200;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _sizeAnimation = Tween<double>(begin: 100, end: 200).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );

    _controller.repeat(reverse: true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewController.onInit(context);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: FColors.primary,
        child: Center(
          child: Column(
            mainAxisSize: .min,
            children: [
              SizedBox(
                width: _logoSize,
                height: _logoSize,
                child: Center(
                  child: AnimatedBuilder(
                    animation: _sizeAnimation,
                    builder: (context, child) => SvgPicture.asset(
                      SvgAssets.fonliLogo,
                      height: _sizeAnimation.value,
                      width: _sizeAnimation.value,
                      colorFilter: const ColorFilter.mode(
                        FColors.secondaryDarker,
                        // FColors.tertiary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
