import '../localization/validator_messages.dart';

/// Returns a validator that fails if value does not match [regex].
/// [message] overrides the default invalid format message when provided.
String? Function(String?) createRegexValidator(
  ValidatorMessages messages,
  RegExp regex, {
  String? message,
}) {
  final errorMessage = message ?? messages.regexInvalid;
  return (String? value) {
    if (value == null || value.isEmpty) {
      return null; // Let required validator handle empty
    }
    if (!regex.hasMatch(value)) {
      return errorMessage;
    }
    return null;
  };
}
