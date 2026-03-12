# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## About

Taql is a Ruby gem that formats SQL query results into pretty-printed tables (ASCII or Markdown). Provides both a CLI (`taql "SELECT ..."`) and programmatic API (`Taql.execute(query)`) for use with Rails/ActiveRecord.

## Commands

```bash
bundle exec rake          # Run tests + lint (default)
rake test                 # Run all tests (minitest)
rake test TEST=test/test_table.rb                        # Single test file
rake test TEST=test/test_table.rb TESTOPTS="--name=test_something"  # Single test method
rake standard             # Lint (Standard Ruby)
rake standard:fix         # Auto-fix lint issues
bin/setup                 # Install dependencies
```

## Architecture

- `lib/taql.rb` — Main module; `.execute(query, options, connection:)` entry point
- `lib/taql/table.rb` — Table formatting (ASCII borders + Markdown mode); handles column width calculation
- `lib/taql/list.rb` — Vertical list formatting; used when table exceeds terminal width
- `lib/taql/cli.rb` — CLI parser (`--markdown/-m` flag); loads Rails env, calls `Taql.execute`
- `lib/taql/railtie.rb` — Rails integration; sets `@default_connection` from ActiveRecord pool
- `exe/taql` — CLI executable entry point

**Flow:** CLI loads Rails environment → parses args → `Taql.execute` uses ActiveRecord connection (from Railtie or explicit) → auto-selects `Table` or `List` based on terminal width → prints formatted output.

## Testing

Tests use Minitest with mocked database connections. Test files mirror lib structure: `test_taql.rb`, `test_table.rb`, `test_list.rb`, `test_cli.rb`. CI runs on Ruby 3.4 via GitHub Actions.
