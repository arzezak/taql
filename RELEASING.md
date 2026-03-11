# Releasing

1. Update version in `lib/taql/version.rb`
2. Run `bundle install` to update lockfile
3. Update `CHANGELOG.md` with new version and changes
4. Commit: `git commit -am "Release vX.Y.Z"`
5. Run `bundle exec rake release` (builds gem, creates git tag, pushes to RubyGems)
