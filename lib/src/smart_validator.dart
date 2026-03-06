import 'localization/validator_locale.dart';
import 'localization/validator_messages.dart';
import 'validators/email_validator.dart';
import 'validators/length_validator.dart';
import 'validators/password_validator.dart';
import 'validators/phone_validator.dart';
import 'validators/regex_validator.dart';
import 'validators/required_validator.dart';

/// Composable form validators for Flutter. Use with [SmartValidator.combine]
/// and factory methods for [TextFormField.validator] and similar APIs.
class SmartValidator {
  SmartValidator._();

  static ValidatorMessages _messages = const ValidatorMessages();
  static final Map<String, ValidatorMessages> _translations = {
    ...ValidatorMessages.builtInTranslations,
  };

  /// Override default error messages globally.
  ///
  /// Use [locale] (built-in sample locales), [localeCode] (any locale/country),
  /// or [messages] (custom strings).
  ///
  /// Example with locale:
  /// ```dart
  /// SmartValidator.configure(locale: ValidatorLocale.es);
  /// ```
  ///
  /// Example with locale code (country/region supported):
  /// ```dart
  /// SmartValidator.registerTranslations({
  ///   'en-us': ValidatorMessages(required: 'Required'),
  ///   'en-gb': ValidatorMessages(required: 'Required'),
  ///   'fr-ca': ValidatorMessages(required: 'Champ obligatoire'),
  /// });
  /// SmartValidator.configure(localeCode: 'fr_CA');
  /// ```
  ///
  /// Example with custom messages:
  /// ```dart
  /// SmartValidator.configure(
  ///   messages: ValidatorMessages(
  ///     required: "This field is required",
  ///     email: "Invalid email address",
  ///   ),
  /// );
  /// ```
  static void configure({
    ValidatorLocale? locale,
    String? localeCode,
    ValidatorMessages? messages,
  }) {
    if (locale != null) {
      _messages = ValidatorMessages.forLocale(locale);
    }
    if (localeCode != null) {
      _messages = ValidatorMessages.forLocaleCode(
        localeCode,
        registeredTranslations: _translations,
      );
    }
    if (messages != null) {
      _messages = messages;
    }
  }

  /// Registers translations for any locale code (language or language-country).
  ///
  /// Keys can be provided as 'en', 'en-US', or 'en_US'. They will be normalized.
  /// Existing keys are overwritten.
  static void registerTranslations(
      Map<String, ValidatorMessages> translations) {
    for (final entry in translations.entries) {
      final key = ValidatorMessages.normalizeLocaleCode(entry.key);
      _translations[key] = entry.value;
    }
  }

  /// Returns the currently configured messages (for testing or custom validators).
  static ValidatorMessages get messages => _messages;

  /// Validator that fails if the value is null or empty.
  static String? Function(String?) required() {
    return createRequiredValidator(_messages);
  }

  /// Validator that checks email format (empty is valid; use with [required] for mandatory fields).
  static String? Function(String?) email() {
    return createEmailValidator(_messages);
  }

  /// Validator that checks password strength.
  ///
  /// [minLength] default 8. [requireUppercase], [requireLowercase], [requireNumbers],
  /// [requireSpecial] control which character types are required.
  static String? Function(String?) password({
    int minLength = 8,
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireNumbers = true,
    bool requireSpecial = false,
  }) {
    return createPasswordValidator(
      _messages,
      minLength: minLength,
      requireUppercase: requireUppercase,
      requireLowercase: requireLowercase,
      requireNumbers: requireNumbers,
      requireSpecial: requireSpecial,
    );
  }

  /// Validator that checks international phone format (E.164-like).
  static String? Function(String?) phone() {
    return createPhoneValidator(_messages);
  }

  /// Validator that fails if the value length is less than [length].
  static String? Function(String?) minLength(int length) {
    return createMinLengthValidator(_messages, length);
  }

  /// Validator that fails if the value length exceeds [length].
  static String? Function(String?) maxLength(int length) {
    return createMaxLengthValidator(_messages, length);
  }

  /// Validator that fails if the value does not match [regex].
  /// [message] is optional; uses default invalid format message if not provided.
  static String? Function(String?) regex(RegExp regex, {String? message}) {
    return createRegexValidator(_messages, regex, message: message);
  }

  /// Wraps a custom function as a validator (same signature as FormFieldValidator).
  static String? Function(String?) custom(String? Function(String?) validator) {
    return validator;
  }

  /// Combines multiple validators. Runs them in order and returns the first
  /// non-null error; returns null if all pass.
  static String? Function(String?) combine(
    List<String? Function(String?)> validators,
  ) {
    return (String? value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) return error;
      }
      return null;
    };
  }
}
