# Changelog

## [0.5.0] - 2026-03-11

- Auto-switch to vertical list layout when table exceeds terminal width
- Add List class for vertical output formatting
- Right-align headers in vertical list output

## [0.4.0] - 2026-03-11

- Fix CLI to use passed argv instead of global ARGV
- Fix CLI to use ActiveRecord connection directly after booting Rails
- Memoize Table headers, columns, and column_widths
- Fix headers deduplication for heterogeneous entries
- Raise error when CLI is invoked without a query
- Add --version flag to CLI
- Support Rails 7.2+ lease_connection

## [0.3.7] - 2025-09-01

- Add Railtie

## [0.2.7] - 2025-06-27

- Provide default options

## [0.2.6] - 2025-05-17

- Fix version

## [0.2.5] - 2025-05-17

- Added support for Markdown
- Inject connection
- Add irb to Gemfile
- Update README

## [0.2.4] - 2025-04-17

- Add back missing alias
- Add back support for older rubies
- Map with index

## [0.2.3] - 2025-04-17

- Refactor table code

## [0.2.2] - 2025-04-08

- Fixed a bug displaying empty tables

## [0.2.1] - 2024-08-24

- Fixed release

## [0.2.0] - 2024-08-24

- Added CLI

## [0.1.0] - 2024-08-23

- Added SQL query table formatting
