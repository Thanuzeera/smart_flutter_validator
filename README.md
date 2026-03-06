# smart_flutter_validator

A powerful and composable form validation package for Flutter. Build validated forms with email, password strength, phone, length, regex, and custom validators. Supports localization and works seamlessly with `TextFormField` and Flutter's form APIs.

## Overview

`smart_flutter_validator` provides a clean API to create and combine validators that return `String?` (error message or `null` when valid), matching Flutter's `FormFieldValidator<String?>`.

## Features

- **Email validation** – RFC-style email format
- **Password strength** – configurable min length, uppercase, lowercase, numbers, special characters
- **Phone validation** – international format (E.164-like)
- **Required field** – non-empty after trim
- **Min / max length** – length bounds with localized messages
- **Regex validation** – custom pattern with optional message
- **Custom validators** – use your own `String? Function(String?)`
- **Combine validators** – run multiple validators in sequence, first error wins
- **Localization** – override all messages via `ValidatorMessages`
- **Null safety** – full Dart null safety
- **Tested** – unit tests for core validators

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  smart_flutter_validator: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage

Use with `TextFormField`:

```dart
TextFormField(
  validator: SmartValidator.combine([
    SmartValidator.required(),
    SmartValidator.email(),
  ]),
)
```

### Validators

| Method | Description |
|--------|-------------|
| `SmartValidator.required()` | Value must be non-null and non-empty (after trim). |
| `SmartValidator.email()` | Valid email format. Empty is valid (pair with `required()` if needed). |
| `SmartValidator.password(...)` | Configurable password strength (min length, upper, lower, digits, special). |
| `SmartValidator.phone()` | International phone (10–15 digits, optional `+` and separators). |
| `SmartValidator.minLength(n)` | Length must be ≥ n. |
| `SmartValidator.maxLength(n)` | Length must be ≤ n. |
| `SmartValidator.regex(regex, message?)` | Value must match regex; optional custom message. |
| `SmartValidator.custom(fn)` | Use your own `String? Function(String?)`. |
| `SmartValidator.combine([...])` | Run validators in order; returns first error or `null`. |

### Combine

Run several validators in sequence; the first non-null error is returned. If all pass, returns `null`:

```dart
SmartValidator.combine([
  SmartValidator.required(),
  SmartValidator.minLength(8),
  SmartValidator.email(),
])
```

### Localization

Use built-in translations by configuring a locale:

```dart
// At app startup or when the user changes language
SmartValidator.configure(locale: ValidatorLocale.es);
```

Supported built-in sample locales: `en`, `es`, `fr`, `de`, `pt`, `hi`, `ar`, `it`.

#### All countries / all locales

To support **any** locale/country (e.g. `en_US`, `fr_CA`, `ta_IN`), register translations and configure by locale code:

```dart
SmartValidator.registerTranslations({
  'en-us': ValidatorMessages(required: 'Required'),
  'fr-ca': ValidatorMessages(required: 'Champ obligatoire'),
});

SmartValidator.configure(localeCode: 'fr_CA'); // normalized to 'fr-ca'
```

Lookup order is: **exact locale** → **language fallback** → **English**.

Use [ValidatorMessages.forLocale], [ValidatorMessages.forLanguageCode], or [ValidatorMessages.forLocaleCode] to fetch messages without applying them globally.

Or override with custom messages:

```dart
SmartValidator.configure(
  messages: ValidatorMessages(
    required: "This field is required",
    email: "Invalid email address",
    passwordWeak: "Password is too weak",
    minLength: "Must be at least {min} characters",
    maxLength: "Must be at most {max} characters",
    phone: "Invalid phone number",
    regexInvalid: "Invalid format",
  ),
);
```

Placeholders `{min}` and `{max}` are replaced in length messages. To use with Flutter's `Locale`, call `SmartValidator.configure(locale: validatorLocaleFromCode(locale.languageCode));` when the app locale changes.

### Password options

```dart
SmartValidator.password(
  minLength: 8,
  requireUppercase: true,
  requireLowercase: true,
  requireNumbers: true,
  requireSpecial: false,
)
```

### Regex with custom message

```dart
SmartValidator.regex(
  RegExp(r'^[A-Z][a-z]+$'),
  message: 'Must start with uppercase letter',
)
```

## Example

See the `example/` folder for a small app with:

- **Login** – email + password (required + min length)
- **Register** – email + password strength + confirm password
- **Phone** – required + phone validator

Run the example:

```bash
cd example && flutter run
```

## Contributing

Contributions are welcome. Please open an issue or pull request on the repository.

## License

This project is licensed under the MIT License – see the [LICENSE](LICENSE) file for details.
# smart_flutter_validator
