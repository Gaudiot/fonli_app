import 'package:flutter/services.dart';

/*
  Colors are based on the following palette:
  https://coolors.co/39b3b3-ebe5c2-e07a5f-3d405b
*/

class FColors {
  FColors._();

  static const Color white = Color(0xFFFFFFFF);

  static const Color black = Color(0xFF000000);

  //MARK: - Primary
  static const Color primaryDarkest = Color(0xFFDCD193);
  static const Color primaryDarker = Color(0xFFE1D8A3);
  static const Color primaryDark = Color(0xFFE6DEB2);
  static const Color primary = Color(0xFFEBE5C2);
  static const Color primaryLight = Color(0xFFF0EBD1);
  static const Color primaryLighter = Color(0xFFF4F1DE);
  static const Color primaryLightest = Color(0xFFFAF8F0);

  //MARK: - Secondary
  static const Color secondaryDarkest = Color(0xFF2C8C8C);
  static const Color secondaryDarker = Color(0xFF319B9B);
  static const Color secondaryDark = Color(0xFF36ABAB);
  static const Color secondary = Color(0xFF39B3B3);
  static const Color secondaryLight = Color(0xFF45CACA);
  static const Color secondaryLighter = Color(0xFF54C9C9);
  static const Color secondaryLightest = Color(0xFF64CECE);

  //MARK: - Tertiary
  static const Color tertiaryDarkest = Color(0xFFD85531);
  static const Color tertiaryDarker = Color(0xFFDB6443);
  static const Color tertiaryDark = Color(0xFFDE7254);
  static const Color tertiary = Color(0xFFE07A5F);
  static const Color tertiaryLight = Color(0xFFE58E76);
  static const Color tertiaryLighter = Color(0xFFE89C87);
  static const Color tertiaryLightest = Color(0xFFEBAA98);

  //MARK: - Quaternary
  static const Color quaternaryDarkest = Color(0xFF292B3D);
  static const Color quaternaryDarker = Color(0xFF313349);
  static const Color quaternaryDark = Color(0xFF393C56);
  static const Color quaternary = Color(0xFF3D405B);
  static const Color quaternaryLight = Color(0xFF494D6E);
  static const Color quaternaryLighter = Color(0xFF52567A);
  static const Color quaternaryLightest = Color(0xFF5A5E87);

  //MARK: - Feedback
  static const Color feedbackCorrect = Color.fromARGB(255, 150, 225, 145);
  static const Color feedbackIncorrect = Color.fromARGB(255, 224, 95, 95);
}
