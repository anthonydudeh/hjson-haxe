# Note:
Versions under 1.0.3 should not be used.

# Changelog

## [1.0.3] – 2025-09-15
### Changes
- Modularized `Token` and `TokenType` into separate files.
- Added support for optional quotes and commas in HJSON syntax.
- Added file input/output support (`parseFile` and `saveToFile`).
- Refactored HJSON parser and writer for better maintainability.

## [1.0.2] – 2025-08-30
### Changes
- Deprecated the library; this library should not be used.

## [1.0.1] – 2025-08-20
### Changes
- Fixing URL in `haxelib.json`

## [1.0.0] – 2025-08-15
### Initial Release
- Core HJSON parsing and writing functionality.
- Handles objects, arrays, numbers, strings, booleans, and nulls.
- Supports optional commas (configurable).
