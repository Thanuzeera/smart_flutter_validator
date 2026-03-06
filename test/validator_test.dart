import 'package:flutter_test/flutter_test.dart';
import 'package:smart_flutter_validator/smart_flutter_validator.dart';

void main() {
  group('Required validator', () {
    late String? Function(String?) validate;

    setUp(() {
      validate = SmartValidator.required();
    });

    test('returns error for null', () {
      expect(validate(null), isNotNull);
    });

    test('returns error for empty string', () {
      expect(validate(''), isNotNull);
    });

    test('returns error for whitespace only', () {
      expect(validate('   '), isNotNull);
    });

    test('returns null for non-empty string', () {
      expect(validate('hello'), isNull);
    });

    test('returns null for string with content', () {
      expect(validate('  x  '), isNull);
    });
  });

  group('Email validator', () {
    late String? Function(String?) validate;

    setUp(() {
      validate = SmartValidator.email();
    });

    test('returns null for null or empty (required handles that)', () {
      expect(validate(null), isNull);
      expect(validate(''), isNull);
    });

    test('returns error for invalid emails', () {
      expect(validate('invalid'), isNotNull);
      expect(validate('@domain.com'), isNotNull);
      expect(validate('user@'), isNotNull);
      expect(validate('user@.com'), isNotNull);
    });

    test('returns null for valid emails', () {
      expect(validate('user@example.com'), isNull);
      expect(validate('a@b.co'), isNull);
      expect(validate('user.name+tag@example.co.uk'), isNull);
    });
  });

  group('Password validator', () {
    test('returns null for null or empty', () {
      final validate = SmartValidator.password();
      expect(validate(null), isNull);
      expect(validate(''), isNull);
    });

    test('returns error when too short', () {
      final validate = SmartValidator.password(minLength: 8);
      expect(validate('Short1!'), isNotNull);
    });

    test('returns error when missing uppercase', () {
      final validate = SmartValidator.password(requireUppercase: true);
      expect(validate('lowercase123'), isNotNull);
    });

    test('returns error when missing lowercase', () {
      final validate = SmartValidator.password(requireLowercase: true);
      expect(validate('UPPERCASE123'), isNotNull);
    });

    test('returns error when missing numbers', () {
      final validate = SmartValidator.password(requireNumbers: true);
      expect(validate('NoNumbersHere'), isNotNull);
    });

    test('returns null when all requirements met', () {
      final validate = SmartValidator.password(
        minLength: 8,
        requireUppercase: true,
        requireLowercase: true,
        requireNumbers: true,
      );
      expect(validate('Password1'), isNull);
    });

    test('returns error when special required but not present', () {
      final validate = SmartValidator.password(requireSpecial: true);
      expect(validate('Password1'), isNotNull);
    });

    test('returns null when special present', () {
      final validate = SmartValidator.password(requireSpecial: true);
      expect(validate('Password1!'), isNull);
    });
  });

  group('Combine validator', () {
    test('returns first error from list', () {
      final validate = SmartValidator.combine([
        SmartValidator.required(),
        SmartValidator.email(),
      ]);
      expect(validate(null), isNotNull);
      expect(validate(''), isNotNull);
      expect(validate('notanemail'), isNotNull);
      expect(validate('user@example.com'), isNull);
    });

    test('runs validators in order', () {
      final validate = SmartValidator.combine([
        SmartValidator.required(),
        SmartValidator.minLength(3),
      ]);
      expect(validate('ab'), isNotNull); // minLength error
      expect(validate('abc'), isNull);
    });

    test('returns null when all pass', () {
      final validate = SmartValidator.combine([
        SmartValidator.required(),
        SmartValidator.email(),
      ]);
      expect(validate('test@example.com'), isNull);
    });
  });

  group('MinLength validator', () {
    test('returns error when shorter than min', () {
      final validate = SmartValidator.minLength(5);
      expect(validate('1234'), isNotNull);
    });

    test('returns null when equal or longer', () {
      final validate = SmartValidator.minLength(5);
      expect(validate('12345'), isNull);
      expect(validate('123456'), isNull);
    });

    test('returns null for null', () {
      final validate = SmartValidator.minLength(5);
      expect(validate(null), isNull);
    });
  });

  group('MaxLength validator', () {
    test('returns error when longer than max', () {
      final validate = SmartValidator.maxLength(5);
      expect(validate('123456'), isNotNull);
    });

    test('returns null when equal or shorter', () {
      final validate = SmartValidator.maxLength(5);
      expect(validate('12345'), isNull);
      expect(validate('1234'), isNull);
    });
  });

  group('Phone validator', () {
    late String? Function(String?) validate;

    setUp(() {
      validate = SmartValidator.phone();
    });

    test('returns null for null or empty', () {
      expect(validate(null), isNull);
      expect(validate(''), isNull);
    });

    test('returns error for too short', () {
      expect(validate('123'), isNotNull);
    });

    test('returns null for valid formats', () {
      expect(validate('1234567890'), isNull);
      expect(validate('+1234567890'), isNull);
      expect(validate('+1 234 567 8900'), isNull);
    });
  });

  group('Regex validator', () {
    test('returns error when pattern does not match', () {
      final validate = SmartValidator.regex(RegExp(r'^[A-Z]'));
      expect(validate('lower'), isNotNull);
    });

    test('returns null when pattern matches', () {
      final validate = SmartValidator.regex(RegExp(r'^[A-Z]'));
      expect(validate('Upper'), isNull);
    });

    test('uses custom message when provided', () {
      final validate = SmartValidator.regex(
        RegExp(r'^\d+$'),
        message: 'Digits only',
      );
      expect(validate('abc'), 'Digits only');
    });
  });

  group('Custom validator', () {
    test('uses provided function', () {
      final validate = SmartValidator.custom((String? value) {
        if (value == 'secret') return null;
        return 'Not the secret';
      });
      expect(validate('secret'), isNull);
      expect(validate('other'), 'Not the secret');
    });
  });

  group('Localization', () {
    test('configure(messages) overrides messages', () {
      SmartValidator.configure(
        messages: const ValidatorMessages(
          required: 'Campo obbligatorio',
          email: 'Email non valida',
        ),
      );
      final requiredValidator = SmartValidator.required();
      final emailValidator = SmartValidator.email();
      expect(requiredValidator(''), 'Campo obbligatorio');
      expect(emailValidator('bad'), 'Email non valida');
      SmartValidator.configure(messages: const ValidatorMessages());
    });

    test('configure(locale) uses built-in translations', () {
      SmartValidator.configure(locale: ValidatorLocale.es);
      final requiredValidator = SmartValidator.required();
      final emailValidator = SmartValidator.email();
      expect(requiredValidator(''), 'Este campo es obligatorio');
      expect(emailValidator('x'), 'Introduce una dirección de correo válida');
      SmartValidator.configure(locale: ValidatorLocale.en);
    });

    test('ValidatorMessages.forLocale returns locale messages', () {
      final es = ValidatorMessages.forLocale(ValidatorLocale.es);
      expect(es.required, 'Este campo es obligatorio');
      expect(es.phone, 'Introduce un número de teléfono válido');
      final fr = ValidatorMessages.forLocale(ValidatorLocale.fr);
      expect(fr.required, 'Ce champ est obligatoire');
    });

    test('ValidatorMessages.forLanguageCode parses language code', () {
      final de = ValidatorMessages.forLanguageCode('de');
      expect(de.required, 'Dieses Feld ist erforderlich');
      final en = ValidatorMessages.forLanguageCode('zh');
      expect(en.required, 'This field is required');
    });

    test('ValidatorMessages.forLocaleCode supports country codes with fallback',
        () {
      final frCa = ValidatorMessages.forLocaleCode('fr_CA');
      expect(frCa.required, 'Ce champ est obligatoire');

      final ptBr = ValidatorMessages.forLocaleCode('pt-BR');
      expect(ptBr.required, 'Este campo é obrigatório');

      final unknown = ValidatorMessages.forLocaleCode('zz-ZZ');
      expect(unknown.required, 'This field is required');
    });
  });
}
