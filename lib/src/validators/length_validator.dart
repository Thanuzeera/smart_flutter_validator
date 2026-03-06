import '../localization/validator_messages.dart';

/// Returns a validator that fails if length is less than [length].
String? Function(String?) createMinLengthValidator(
  ValidatorMessages messages,
  int length,
) {
  return (String? value) {
    if (value == null) return null;
    if (value.length < length) {
      return messages.minLengthMessage(length);
    }
    return null;
  };
}

/// Returns a validator that fails if length exceeds [length].
String? Function(String?) createMaxLengthValidator(
  ValidatorMessages messages,
  int length,
) {
  return (String? value) {
    if (value == null) return null;
    if (value.length > length) {
      return messages.maxLengthMessage(length);
    }
    return null;
  };
}
