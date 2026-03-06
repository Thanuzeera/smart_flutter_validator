import '../localization/validator_messages.dart';

/// Returns a validator that fails if the value is null or empty (after trim).
String? Function(String?) createRequiredValidator(ValidatorMessages messages) {
  return (String? value) {
    if (value == null || value.trim().isEmpty) {
      return messages.required;
    }
    return null;
  };
}
