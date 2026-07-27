// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get common__retry => 'Retry';

  @override
  String get common__submit => 'Submit';

  @override
  String get common__next => 'Next';

  @override
  String get common__skip => 'Skip';

  @override
  String get common__save => 'Save';

  @override
  String get onboarding__target_language_title =>
      'Select the language you want to learn.';

  @override
  String get onboarding__base_language_title => 'Choose a language you speak.';

  @override
  String get onboarding__lifestyle_title => 'Tell us more about yourself.';

  @override
  String get onboarding__lifestyle_description =>
      'With this we can create personalized exercises for you!';

  @override
  String get email => 'E-mail';

  @override
  String get username => 'Username';

  @override
  String get email_or_username => 'E-mail/Username';

  @override
  String get password => 'Password';

  @override
  String get login => 'Login';

  @override
  String get have_account => 'Already have an account?';

  @override
  String get no_account => 'Don\'t have an account?';

  @override
  String get signup => 'Sign Up';

  @override
  String get logout => 'Log Out';

  @override
  String get complete => 'Complete';

  @override
  String get select_exercise => 'Select an exercise';

  @override
  String get exercise_native_to_foreign => 'Native to Foreign';

  @override
  String get exercise_foreign_to_native => 'Foreign to Native';

  @override
  String get exercise_conjugation => 'Verb Conjugation';

  @override
  String get exercise_story => 'Story Translation';

  @override
  String get base_language => 'Base Language';

  @override
  String get target_language => 'Target Language';

  @override
  String get lang__english => 'English';

  @override
  String get lang__portuguese => 'Portuguese';

  @override
  String get lang__french => 'French';

  @override
  String get lang__italian => 'Italian';

  @override
  String get user_settings => 'User Settings';

  @override
  String get lifestyle => 'Lifestyle';

  @override
  String get lifestyle_header =>
      'Your lifestyle helps us create more personalized exercises for you.';

  @override
  String get insert_translation => 'insert translation';

  @override
  String get exercise_finished => 'Exercise finished';

  @override
  String get exercise_no_mistake =>
      'You got all answers correct! You are a master of the language!';

  @override
  String exercise_mistakes(int correctAnswersQuantity, int questionsQuantity) {
    return 'You got $correctAnswersQuantity out of $questionsQuantity correct';
  }

  @override
  String get exercise_mistakes_output => 'Here are your mistakes:';

  @override
  String get exercise_load_fail => 'Failed to load exercise';

  @override
  String conjugate_for(String prompt) {
    return 'conjugate for: $prompt';
  }

  @override
  String get insert_conjugation => 'Insert conjugation...';

  @override
  String get translate_story => 'Translate the story:';

  @override
  String get input_translation => 'Input the translation here...';

  @override
  String translation_score(int score, int total) {
    return 'Score: $score/$total';
  }

  @override
  String get correct_translation => 'Correct translation';

  @override
  String get settings__title => 'Settings';

  @override
  String get settings__language_learning_title => 'Language Learning Settings';

  @override
  String get settings__lifestyle_settings => 'Lifestyle Settings';
}
