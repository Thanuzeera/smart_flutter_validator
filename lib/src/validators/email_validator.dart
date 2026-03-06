import '../localization/validator_messages.dart';

/// RFC 5322 simplified email regex (covers most practical cases).
final RegExp _emailRegex = RegExp(
  r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\.[a-zA-Z]{2,}$',
);

/// Returns a validator that checks email format.
String? Function(String?) createEmailValidator(ValidatorMessages messages) {
  return (String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Let required validator handle empty
    }
    if (!_emailRegex.hasMatch(value.trim())) {
      return messages.email;
    }
    return null;
  };
}
