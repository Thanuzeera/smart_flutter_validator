/// Supported locales for built-in validator messages.
///
/// Use with [ValidatorMessages.forLocale] or [SmartValidator.configure].
enum ValidatorLocale {
  /// English
  en,

  /// Spanish
  es,

  /// French
  fr,

  /// German
  de,

  /// Portuguese
  pt,

  /// Hindi
  hi,

  /// Arabic
  ar,

  /// Italian
  it,
}

extension ValidatorLocaleExtension on ValidatorLocale {
  /// ISO 639-1 language code (e.g. 'en', 'es').
  String get languageCode => name;
}

/// Parses a language code to [ValidatorLocale].
/// Returns [ValidatorLocale.en] for unsupported or unknown codes.
ValidatorLocale validatorLocaleFromCode(String languageCode) {
  final code = languageCode.toLowerCase().split('-').first;
  switch (code) {
    case 'en':
      return ValidatorLocale.en;
    case 'es':
      return ValidatorLocale.es;
    case 'fr':
      return ValidatorLocale.fr;
    case 'de':
      return ValidatorLocale.de;
    case 'pt':
      return ValidatorLocale.pt;
    case 'hi':
      return ValidatorLocale.hi;
    case 'ar':
      return ValidatorLocale.ar;
    case 'it':
      return ValidatorLocale.it;
    default:
      return ValidatorLocale.en;
  }
}
