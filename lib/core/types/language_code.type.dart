// ignore_for_file: constant_identifier_names

enum LanguageCode {
  en_US("en_US"),
  pt_BR("pt_BR"),
  fr_FR("fr_FR"),
  it_IT("it_IT"),
  de_DE("de_DE"),
  es_ES("es_ES");

  final String code;

  const LanguageCode(this.code);

  factory LanguageCode.fromString(String code) {
    return LanguageCode.values.firstWhere(
      (element) => element.code == code,
      orElse: () => .en_US,
    );
  }

  String get countryCode {
    switch (this) {
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

  static List<LanguageCode> get all => [
    LanguageCode.en_US,
    LanguageCode.pt_BR,
    LanguageCode.fr_FR,
    LanguageCode.it_IT,
    LanguageCode.de_DE,
    LanguageCode.es_ES,
  ];

  String get languageName {
    switch (this) {
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
