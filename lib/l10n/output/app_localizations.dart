import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'output/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// Retry label
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get common__retry;

  /// Submit label
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get common__submit;

  /// Save label
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// E-mail label
  ///
  /// In en, this message translates to:
  /// **'E-mail'**
  String get email;

  /// Username label
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// E-mail or username label
  ///
  /// In en, this message translates to:
  /// **'E-mail/Username'**
  String get email_or_username;

  /// Password label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Login button
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Text displayed to direct user to login form
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get have_account;

  /// Text displayed to direct user to sign up form
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get no_account;

  /// Sign up label
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signup;

  /// Log out label
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logout;

  /// Complete label
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// Text to select an exercise
  ///
  /// In en, this message translates to:
  /// **'Select an exercise'**
  String get select_exercise;

  /// Native to foreign exercise label
  ///
  /// In en, this message translates to:
  /// **'Native to Foreign'**
  String get exercise_native_to_foreign;

  /// Foreign to native exercise label
  ///
  /// In en, this message translates to:
  /// **'Foreign to Native'**
  String get exercise_foreign_to_native;

  /// Word conjugation exercise label
  ///
  /// In en, this message translates to:
  /// **'Word Conjugation'**
  String get exercise_conjugation;

  /// Story translation exercise label
  ///
  /// In en, this message translates to:
  /// **'Story Translation'**
  String get exercise_story;

  /// Native language label
  ///
  /// In en, this message translates to:
  /// **'Native Language'**
  String get native_lang;

  /// Foreign language label
  ///
  /// In en, this message translates to:
  /// **'Foreign Language'**
  String get foreign_lang;

  /// English
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get lang__english;

  /// Portuguese
  ///
  /// In en, this message translates to:
  /// **'Portuguese'**
  String get lang__portuguese;

  /// French
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get lang__french;

  /// Italian
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get lang__italian;

  /// User settings label
  ///
  /// In en, this message translates to:
  /// **'User Settings'**
  String get user_settings;

  /// Lifestyle label
  ///
  /// In en, this message translates to:
  /// **'Lifestyle'**
  String get lifestyle;

  /// Lifestyle header
  ///
  /// In en, this message translates to:
  /// **'Your lifestyle helps us create more personalized exercises for you.'**
  String get lifestyle_header;

  /// insert translation label
  ///
  /// In en, this message translates to:
  /// **'insert translation'**
  String get insert_translation;

  /// Exercise finished label
  ///
  /// In en, this message translates to:
  /// **'Exercise finished'**
  String get exercise_finished;

  /// Text exhibited when the user finish an execise with no mistakes
  ///
  /// In en, this message translates to:
  /// **'You got all answers correct! You are a master of the language!'**
  String get exercise_no_mistake;

  /// Text exhibited when the user finish an exercise with some mistakes
  ///
  /// In en, this message translates to:
  /// **'You got {correctAnswersQuantity} out of {questionsQuantity} correct'**
  String exercise_mistakes(int correctAnswersQuantity, int questionsQuantity);

  /// Title displayed before users mistake on exercise
  ///
  /// In en, this message translates to:
  /// **'Here are your mistakes:'**
  String get exercise_mistakes_output;

  /// Text displayed when the exercise fails to load
  ///
  /// In en, this message translates to:
  /// **'Failed to load exercise'**
  String get exercise_load_fail;

  /// Command displayed at word conjugation
  ///
  /// In en, this message translates to:
  /// **'conjugate for: {prompt}'**
  String conjugate_for(String prompt);

  /// Placeholder to insert conjugation
  ///
  /// In en, this message translates to:
  /// **'Insert conjugation...'**
  String get insert_conjugation;

  /// Translate story label
  ///
  /// In en, this message translates to:
  /// **'Translate the story:'**
  String get translate_story;

  /// Placeholder to input story translation
  ///
  /// In en, this message translates to:
  /// **'Input the translation here...'**
  String get input_translation;

  /// The user's score on story translation
  ///
  /// In en, this message translates to:
  /// **'Score: {score}/{total}'**
  String translation_score(int score, int total);

  /// Correct translation label
  ///
  /// In en, this message translates to:
  /// **'Correct translation'**
  String get correct_translation;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
