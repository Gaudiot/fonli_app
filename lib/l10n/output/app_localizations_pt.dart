// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get common__retry => 'Retentar';

  @override
  String get common__submit => 'Enviar';

  @override
  String get common__next => 'Próximo';

  @override
  String get save => 'Salvar';

  @override
  String get email => 'E-mail';

  @override
  String get username => 'Nome de usuário';

  @override
  String get email_or_username => 'E-mail/Nome de usuário';

  @override
  String get password => 'Senha';

  @override
  String get login => 'Login';

  @override
  String get have_account => 'Já tem conta?';

  @override
  String get no_account => 'Ainda não tem conta?';

  @override
  String get signup => 'Cadastro';

  @override
  String get logout => 'Sair';

  @override
  String get complete => 'Concluir';

  @override
  String get select_exercise => 'Selecione um exercício';

  @override
  String get exercise_native_to_foreign => 'Nativo para Estrangeiro';

  @override
  String get exercise_foreign_to_native => 'Estrangeiro para Nativo';

  @override
  String get exercise_conjugation => 'Conjugação Verbal';

  @override
  String get exercise_story => 'Traduzir história';

  @override
  String get native_lang => 'Lingua Nativa';

  @override
  String get foreign_lang => 'Lingua Estrangeira';

  @override
  String get lang__english => 'Inglês';

  @override
  String get lang__portuguese => 'Português';

  @override
  String get lang__french => 'Francês';

  @override
  String get lang__italian => 'Italiano';

  @override
  String get user_settings => 'Preferência do usuário';

  @override
  String get lifestyle => 'Cotidiano';

  @override
  String get lifestyle_header =>
      'Seu cotidiano nos ajuda a criar exercícios personalizados para você.';

  @override
  String get insert_translation => 'insira tradução';

  @override
  String get exercise_finished => 'Exercício finalizado';

  @override
  String get exercise_no_mistake =>
      'Você acertou todas! Um verdadeiro dicionário ambulante!';

  @override
  String exercise_mistakes(int correctAnswersQuantity, int questionsQuantity) {
    return 'Você acertou $correctAnswersQuantity de $questionsQuantity';
  }

  @override
  String get exercise_mistakes_output => 'Aqui estão os seus erros:';

  @override
  String get exercise_load_fail => 'Falha ao carregar exercício';

  @override
  String conjugate_for(String prompt) {
    return 'cConjugue para: $prompt';
  }

  @override
  String get insert_conjugation => 'Insira conjugação...';

  @override
  String get translate_story => 'Traduza a história:';

  @override
  String get input_translation => 'Insira a tradução aqui...';

  @override
  String translation_score(int score, int total) {
    return 'Pontuação: $score/$total';
  }

  @override
  String get correct_translation => 'Tradução correta';

  @override
  String get settings__title => 'Configurações';

  @override
  String get settings__change_learning_language =>
      'Mudar Lingua de Aprendizagem';

  @override
  String get settings__lifestyle_settings => 'Definir Cotidiano';
}
