import 'validator_locale.dart';

/// Default and customizable messages for validator errors.
///
/// Use [ValidatorMessages.forLocale] for built-in translations, or construct
/// with custom strings and pass to [SmartValidator.configure].
class ValidatorMessages {
  /// Message when a required field is empty.
  final String required;

  /// Message when email format is invalid.
  final String email;

  /// Message when password does not meet strength requirements.
  final String passwordWeak;

  /// Message when value is shorter than minimum length. Use {min} as placeholder.
  final String minLength;

  /// Message when value exceeds maximum length. Use {max} as placeholder.
  final String maxLength;

  /// Message when phone number format is invalid.
  final String phone;

  /// Message when value does not match regex (fallback if no custom message).
  final String regexInvalid;

  const ValidatorMessages({
    this.required = 'This field is required',
    this.email = 'Please enter a valid email address',
    this.passwordWeak = 'Password does not meet the requirements',
    this.minLength = 'Must be at least {min} characters',
    this.maxLength = 'Must be at most {max} characters',
    this.phone = 'Please enter a valid phone number',
    this.regexInvalid = 'Invalid format',
  });

  /// Replaces placeholders like {min} and {max} in message templates.
  String minLengthMessage(int min) =>
      minLength.replaceAll('{min}', min.toString());

  String maxLengthMessage(int max) =>
      maxLength.replaceAll('{max}', max.toString());

  /// Returns predefined messages for the given [locale].
  static ValidatorMessages forLocale(ValidatorLocale locale) {
    return _localeMessages[locale] ?? const ValidatorMessages();
  }

  /// Returns predefined messages for the given language code (e.g. 'en', 'es').
  /// Falls back to English for unsupported codes.
  static ValidatorMessages forLanguageCode(String languageCode) {
    return forLocale(validatorLocaleFromCode(languageCode));
  }

  /// Returns messages for an arbitrary locale code (e.g. 'en', 'en-US', 'en_US', 'fr-CA').
  ///
  /// Lookup order:
  /// - exact match (normalized, e.g. 'fr-ca')
  /// - language-only fallback (e.g. 'fr')
  /// - English default
  ///
  /// If [registeredTranslations] is provided, it is used as the source of truth.
  /// Otherwise, built-in translations are used.
  static ValidatorMessages forLocaleCode(
    String localeCode, {
    Map<String, ValidatorMessages>? registeredTranslations,
  }) {
    final source = registeredTranslations ?? builtInTranslations;
    final normalized = normalizeLocaleCode(localeCode);
    final exact = source[normalized];
    if (exact != null) return exact;

    final languageOnly = normalized.split('-').first;
    final lang = source[languageOnly];
    if (lang != null) return lang;

    return source['en'] ?? const ValidatorMessages();
  }

  /// Normalizes locale codes to lowercase and uses '-' as the separator.
  /// Examples: 'EN_us' -> 'en-us', 'pt-BR' -> 'pt-br', 'fr' -> 'fr'.
  static String normalizeLocaleCode(String localeCode) {
    return localeCode.trim().replaceAll('_', '-').toLowerCase();
  }

  /// Built-in translations keyed by locale code.
  ///
  /// Note: This is intentionally not exhaustive. For “all countries/locales”,
  /// register your own translations via [SmartValidator.registerTranslations]
  /// and call [SmartValidator.configure(localeCode: ...)].
  static Map<String, ValidatorMessages> get builtInTranslations => {
        'en': forLocale(ValidatorLocale.en),
        'es': forLocale(ValidatorLocale.es),
        'fr': forLocale(ValidatorLocale.fr),
        'de': forLocale(ValidatorLocale.de),
        'pt': forLocale(ValidatorLocale.pt),
        'hi': forLocale(ValidatorLocale.hi),
        'ar': forLocale(ValidatorLocale.ar),
        'it': forLocale(ValidatorLocale.it),
      };

  static const Map<ValidatorLocale, ValidatorMessages> _localeMessages = {
    ValidatorLocale.en: ValidatorMessages(
      required: 'This field is required',
      email: 'Please enter a valid email address',
      passwordWeak: 'Password does not meet the requirements',
      minLength: 'Must be at least {min} characters',
      maxLength: 'Must be at most {max} characters',
      phone: 'Please enter a valid phone number',
      regexInvalid: 'Invalid format',
    ),
    ValidatorLocale.es: ValidatorMessages(
      required: 'Este campo es obligatorio',
      email: 'Introduce una dirección de correo válida',
      passwordWeak: 'La contraseña no cumple los requisitos',
      minLength: 'Debe tener al menos {min} caracteres',
      maxLength: 'Debe tener como máximo {max} caracteres',
      phone: 'Introduce un número de teléfono válido',
      regexInvalid: 'Formato no válido',
    ),
    ValidatorLocale.fr: ValidatorMessages(
      required: 'Ce champ est obligatoire',
      email: 'Veuillez entrer une adresse e-mail valide',
      passwordWeak: 'Le mot de passe ne respecte pas les exigences',
      minLength: 'Doit contenir au moins {min} caractères',
      maxLength: 'Doit contenir au maximum {max} caractères',
      phone: 'Veuillez entrer un numéro de téléphone valide',
      regexInvalid: 'Format invalide',
    ),
    ValidatorLocale.de: ValidatorMessages(
      required: 'Dieses Feld ist erforderlich',
      email: 'Bitte geben Sie eine gültige E-Mail-Adresse ein',
      passwordWeak: 'Das Passwort erfüllt die Anforderungen nicht',
      minLength: 'Mindestens {min} Zeichen erforderlich',
      maxLength: 'Maximal {max} Zeichen erlaubt',
      phone: 'Bitte geben Sie eine gültige Telefonnummer ein',
      regexInvalid: 'Ungültiges Format',
    ),
    ValidatorLocale.pt: ValidatorMessages(
      required: 'Este campo é obrigatório',
      email: 'Digite um endereço de e-mail válido',
      passwordWeak: 'A senha não atende aos requisitos',
      minLength: 'Deve ter pelo menos {min} caracteres',
      maxLength: 'Deve ter no máximo {max} caracteres',
      phone: 'Digite um número de telefone válido',
      regexInvalid: 'Formato inválido',
    ),
    ValidatorLocale.hi: ValidatorMessages(
      required: 'यह फ़ील्ड आवश्यक है',
      email: 'कृपया एक मान्य ईमेल पता दर्ज करें',
      passwordWeak: 'पासवर्ड आवश्यकताओं को पूरा नहीं करता',
      minLength: 'कम से कम {min} अक्षर होने चाहिए',
      maxLength: 'अधिकतम {max} अक्षर होने चाहिए',
      phone: 'कृपया एक मान्य फ़ोन नंबर दर्ज करें',
      regexInvalid: 'अमान्य प्रारूप',
    ),
    ValidatorLocale.ar: ValidatorMessages(
      required: 'هذا الحقل مطلوب',
      email: 'يرجى إدخال بريد إلكتروني صحيح',
      passwordWeak: 'كلمة المرور لا تلبي المتطلبات',
      minLength: 'يجب أن تكون {min} أحرف على الأقل',
      maxLength: 'يجب ألا تتجاوز {max} حرفاً',
      phone: 'يرجى إدخال رقم هاتف صحيح',
      regexInvalid: 'تنسيق غير صالح',
    ),
    ValidatorLocale.it: ValidatorMessages(
      required: 'Questo campo è obbligatorio',
      email: 'Inserisci un indirizzo email valido',
      passwordWeak: 'La password non soddisfa i requisiti',
      minLength: 'Deve contenere almeno {min} caratteri',
      maxLength: 'Deve contenere al massimo {max} caratteri',
      phone: 'Inserisci un numero di telefono valido',
      regexInvalid: 'Formato non valido',
    ),
  };
}
