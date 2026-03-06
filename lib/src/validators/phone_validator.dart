import '../localization/validator_messages.dart';

/// E.164-like: optional +, then digits (with optional spaces/dashes).
/// Minimum length typically 10-15 digits.
final RegExp _phoneRegex = RegExp(
  r'^\+?[\d\s\-()]{10,20}$',
);

/// Returns a validator that checks international phone format.
String? Function(String?) createPhoneValidator(ValidatorMessages messages) {
  return (String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Let required validator handle empty
    }
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    if (digitsOnly.length < 10 || digitsOnly.length > 15) {
      return messages.phone;
    }
    if (!RegExp(r'^\d+$').hasMatch(digitsOnly)) {
      return messages.phone;
    }
    if (!_phoneRegex.hasMatch(value.trim())) {
      return messages.phone;
    }
    return null;
  };
}
