import '../localization/validator_messages.dart';

/// Returns a validator that checks password strength.
String? Function(String?) createPasswordValidator(
  ValidatorMessages messages, {
  int minLength = 8,
  bool requireUppercase = true,
  bool requireLowercase = true,
  bool requireNumbers = true,
  bool requireSpecial = false,
}) {
  return (String? value) {
    if (value == null || value.isEmpty) {
      return null; // Let required validator handle empty
    }
    if (value.length < minLength) {
      return messages.passwordWeak;
    }
    if (requireUppercase && !value.contains(RegExp(r'[A-Z]'))) {
      return messages.passwordWeak;
    }
    if (requireLowercase && !value.contains(RegExp(r'[a-z]'))) {
      return messages.passwordWeak;
    }
    if (requireNumbers && !value.contains(RegExp(r'[0-9]'))) {
      return messages.passwordWeak;
    }
    if (requireSpecial && !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return messages.passwordWeak;
    }
    return null;
  };
}
