/// Smart Flutter Validator – composable, localized form validation for Flutter.
///
/// Example:
/// ```dart
/// TextFormField(
///   validator: SmartValidator.combine([
///     SmartValidator.required(),
///     SmartValidator.email(),
///   ]),
/// )
/// ```
library;

export 'src/smart_validator.dart';
export 'src/localization/validator_messages.dart';
export 'src/localization/validator_locale.dart';
