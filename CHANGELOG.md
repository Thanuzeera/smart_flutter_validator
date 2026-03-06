# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-03-06

### Added

- Initial release of smart_flutter_validator
- Email validation
- Password strength validation with configurable rules
- Phone number validation (international format)
- Required field validation
- Minimum and maximum length validation
- Regex validation with custom message
- Custom validator support
- Combine multiple validators (sequential, first error wins)
- Localization support via ValidatorMessages
- SmartValidator.configure() for global message override
- Full null safety
- Unit tests for core validators
- Example app with login, register, and phone validation forms
