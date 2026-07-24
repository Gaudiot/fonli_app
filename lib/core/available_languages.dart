enum LanguageCode {
  en_US("en_US"),
  pt_BR("pt_BR"),
  fr_FR("fr_FR"),
  it_IT("it_IT"),
  de_DE("de_DE"),
  es_ES("es_ES");

  final String code;

  const LanguageCode(this.code);
}

class AvailableLanguages {
  const AvailableLanguages._();

  static List<LanguageCode> get languageCodes => [
    LanguageCode.en_US,
    LanguageCode.pt_BR,
    LanguageCode.fr_FR,
    LanguageCode.it_IT,
    LanguageCode.de_DE,
    LanguageCode.es_ES,
  ];

  static String getCountryCodes(LanguageCode languageCode) {
    switch (languageCode) {
      case LanguageCode.en_US:
        return "US";
      case LanguageCode.pt_BR:
        return "BR";
      case LanguageCode.fr_FR:
        return "FR";
      case LanguageCode.it_IT:
        return "IT";
      case LanguageCode.de_DE:
        return "DE";
      case LanguageCode.es_ES:
        return "ES";
    }
  }

  static String getLanguageName(LanguageCode languageCode) {
    switch (languageCode) {
      case LanguageCode.en_US:
        return "English";
      case LanguageCode.pt_BR:
        return "Portuguese";
      case LanguageCode.fr_FR:
        return "French";
      case LanguageCode.it_IT:
        return "Italian";
      case LanguageCode.de_DE:
        return "German";
      case LanguageCode.es_ES:
        return "Spanish";
    }
  }
}
