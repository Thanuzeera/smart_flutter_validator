import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_flutter_validator/smart_flutter_validator.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Flutter Validator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          brightness: Brightness.light,
          primary: const Color(0xFF2563EB),
          secondary: const Color(0xFF7C3AED),
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFF2563EB), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFEF4444)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFEF4444), width: 2),
          ),
          labelStyle: const TextStyle(color: Color(0xFF111827), fontSize: 15),
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2563EB),
            foregroundColor: const Color(0xFFFFFFFF),
            padding: const EdgeInsets.symmetric(vertical: 18),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          elevation: 0,
          height: 72,
          backgroundColor: const Color(0xFF2563EB),
          indicatorColor: Colors.white.withValues(alpha: 0.2),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFFFFFFF),
              );
            }
            return GoogleFonts.plusJakartaSans(
              fontSize: 12,
              color: Colors.white.withValues(alpha: 0.7),
            );
          }),
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: false,
          backgroundColor: const Color(0xFF2563EB),
          foregroundColor: const Color(0xFFFFFFFF),
          titleTextStyle: GoogleFonts.plusJakartaSans(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFFFFFFF),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: const Color(0xFF111827),
          contentTextStyle:
              GoogleFonts.plusJakartaSans(color: const Color(0xFFFFFFFF)),
        ),
      ),
      home: const ExampleHome(),
    );
  }
}

class ExampleHome extends StatefulWidget {
  const ExampleHome({super.key});

  @override
  State<ExampleHome> createState() => _ExampleHomeState();
}

class _ExampleHomeState extends State<ExampleHome> {
  int _selectedIndex = 0;
  ValidatorLocale _locale = ValidatorLocale.en;

  @override
  void initState() {
    super.initState();
    SmartValidator.configure(locale: _locale);
  }

  void _setLocale(ValidatorLocale locale) {
    setState(() {
      _locale = locale;
      SmartValidator.configure(locale: locale);
    });
  }

  String get _localeLabel {
    switch (_locale) {
      case ValidatorLocale.en:
        return 'EN';
      case ValidatorLocale.es:
        return 'ES';
      case ValidatorLocale.fr:
        return 'FR';
      case ValidatorLocale.de:
        return 'DE';
      case ValidatorLocale.pt:
        return 'PT';
      case ValidatorLocale.hi:
        return 'HI';
      case ValidatorLocale.ar:
        return 'AR';
      case ValidatorLocale.it:
        return 'IT';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Smart Validator'),
        scrolledUnderElevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.28),
                  ),
                ),
                child: Text(
                  _localeLabel,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFFFFFFF),
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),
          ),
          PopupMenuButton<ValidatorLocale>(
            icon: const Icon(Icons.language_rounded),
            tooltip: 'Validation language',
            onSelected: _setLocale,
            color: Colors.white,
            itemBuilder: (context) => [
              const PopupMenuItem(
                  value: ValidatorLocale.en, child: Text('English')),
              const PopupMenuItem(
                  value: ValidatorLocale.es, child: Text('Español')),
              const PopupMenuItem(
                  value: ValidatorLocale.fr, child: Text('Français')),
              const PopupMenuItem(
                  value: ValidatorLocale.de, child: Text('Deutsch')),
              const PopupMenuItem(
                  value: ValidatorLocale.pt, child: Text('Português')),
              const PopupMenuItem(
                  value: ValidatorLocale.it, child: Text('Italiano')),
              const PopupMenuItem(
                  value: ValidatorLocale.hi, child: Text('हिन्दी')),
              const PopupMenuItem(
                  value: ValidatorLocale.ar, child: Text('العربية')),
            ],
          ),
        ],
      ),
      body: IndexedStack(
        key: ValueKey(_locale),
        index: _selectedIndex,
        children: [
          LoginForm(locale: _locale),
          RegisterForm(locale: _locale),
          PhoneForm(locale: _locale),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF2563EB),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.login_rounded,
                  label: 'Login',
                  isSelected: _selectedIndex == 0,
                  onTap: () => setState(() => _selectedIndex = 0),
                ),
                _NavItem(
                  icon: Icons.person_add_rounded,
                  label: 'Register',
                  isSelected: _selectedIndex == 1,
                  onTap: () => setState(() => _selectedIndex = 1),
                ),
                _NavItem(
                  icon: Icons.phone_rounded,
                  label: 'Phone',
                  isSelected: _selectedIndex == 2,
                  onTap: () => setState(() => _selectedIndex = 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.white.withValues(alpha: 0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 22,
                color: isSelected
                    ? const Color(0xFFFFFFFF)
                    : Colors.white.withValues(alpha: 0.7),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? const Color(0xFFFFFFFF)
                      : Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormScaffold extends StatelessWidget {
  const _FormScaffold({
    required this.title,
    required this.subtitle,
    required this.locale,
    required this.child,
  });

  final String title;
  final String subtitle;
  final ValidatorLocale locale;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111827),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: const Color(0xFF6B7280),
              height: 1.4,
            ),
          ),
          // const SizedBox(height: 16),
          // _ValidationMessagesPreview(locale: locale),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({required this.locale, super.key});

  final ValidatorLocale locale;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return _FormScaffold(
      title: 'Welcome back',
      subtitle:
          'Sign in with your email. Fields are validated with SmartValidator.',
      locale: widget.locale,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 24,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'you@example.com',
                      prefixIcon: Icon(Icons.email_outlined, size: 22),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: SmartValidator.combine([
                      SmartValidator.required(),
                      SmartValidator.email(),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Min 6 characters',
                      prefixIcon: Icon(Icons.lock_outline_rounded, size: 22),
                    ),
                    obscureText: true,
                    validator: SmartValidator.combine([
                      SmartValidator.required(),
                      SmartValidator.minLength(6),
                    ]),
                  ),
                  const SizedBox(height: 28),
                  FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                const Icon(Icons.check_circle_rounded,
                                    color: Colors.white, size: 22),
                                const SizedBox(width: 12),
                                Text(
                                  'Login form is valid',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({required this.locale, super.key});

  final ValidatorLocale locale;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return _FormScaffold(
      title: 'Create account',
      subtitle:
          'Password must be 8+ characters with uppercase, lowercase, and numbers.',
      locale: widget.locale,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 24,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'you@example.com',
                      prefixIcon: Icon(Icons.email_outlined, size: 22),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: SmartValidator.combine([
                      SmartValidator.required(),
                      SmartValidator.email(),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: '8+ chars, upper, lower, numbers',
                      prefixIcon: Icon(Icons.lock_outline_rounded, size: 22),
                    ),
                    obscureText: true,
                    validator: SmartValidator.combine([
                      SmartValidator.required(),
                      SmartValidator.password(
                        minLength: 8,
                        requireUppercase: true,
                        requireLowercase: true,
                        requireNumbers: true,
                        requireSpecial: false,
                      ),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Confirm password',
                      hintText: 'Re-enter your password',
                      prefixIcon: Icon(Icons.lock_outline_rounded, size: 22),
                    ),
                    obscureText: true,
                    validator: SmartValidator.required(),
                  ),
                  const SizedBox(height: 28),
                  FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                const Icon(Icons.check_circle_rounded,
                                    color: Colors.white, size: 22),
                                const SizedBox(width: 12),
                                Text(
                                  'Registration form is valid',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Create account',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PhoneForm extends StatefulWidget {
  const PhoneForm({required this.locale, super.key});

  final ValidatorLocale locale;

  @override
  State<PhoneForm> createState() => _PhoneFormState();
}

class _PhoneFormState extends State<PhoneForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return _FormScaffold(
      title: 'Phone number',
      subtitle:
          'Enter an international number (10–15 digits). Format: +1 234 567 8900',
      locale: widget.locale,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 24,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Phone number',
                      hintText: '+1 234 567 8900',
                      prefixIcon: Icon(Icons.phone_android_rounded, size: 22),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: SmartValidator.combine([
                      SmartValidator.required(),
                      SmartValidator.phone(),
                    ]),
                  ),
                  const SizedBox(height: 28),
                  FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                const Icon(Icons.check_circle_rounded,
                                    color: Colors.white, size: 22),
                                const SizedBox(width: 12),
                                Text(
                                  'Phone form is valid',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class _ValidationMessagesPreview extends StatelessWidget {
//   const _ValidationMessagesPreview({required this.locale});

//   final ValidatorLocale locale;

//   @override
//   Widget build(BuildContext context) {
//     final m = SmartValidator.messages;
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: const Color(0xFFE5E7EB)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.03),
//             blurRadius: 18,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Row(
//             children: [
//               const Icon(Icons.translate_rounded,
//                   size: 18, color: Color(0xFF7C3AED)),
//               const SizedBox(width: 10),
//               Text(
//                 'Validation messages (live)',
//                 style: GoogleFonts.plusJakartaSans(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w700,
//                   color: const Color(0xFF111827),
//                 ),
//               ),
//               const Spacer(),
//               Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF2563EB).withValues(alpha: 0.08),
//                   borderRadius: BorderRadius.circular(999),
//                   border: Border.all(
//                     color: const Color(0xFF2563EB).withValues(alpha: 0.16),
//                   ),
//                 ),
//                 child: Text(
//                   locale.languageCode.toUpperCase(),
//                   style: GoogleFonts.plusJakartaSans(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w800,
//                     color: const Color(0xFF2563EB),
//                     letterSpacing: 0.8,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           _PreviewRow(label: 'Required', value: m.required),
//           const SizedBox(height: 10),
//           _PreviewRow(label: 'Email', value: m.email),
//           const SizedBox(height: 10),
//           _PreviewRow(label: 'Password', value: m.passwordWeak),
//           const SizedBox(height: 10),
//           _PreviewRow(label: 'Min length', value: m.minLengthMessage(8)),
//         ],
//       ),
//     );
//   }
// }

// class _PreviewRow extends StatelessWidget {
//   const _PreviewRow({required this.label, required this.value});

//   final String label;
//   final String value;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           width: 92,
//           child: Text(
//             label,
//             style: GoogleFonts.plusJakartaSans(
//               fontSize: 12,
//               fontWeight: FontWeight.w600,
//               color: const Color(0xFF6B7280),
//             ),
//           ),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Text(
//             value,
//             style: GoogleFonts.plusJakartaSans(
//               fontSize: 12,
//               fontWeight: FontWeight.w600,
//               color: const Color(0xFF111827),
//               height: 1.25,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
