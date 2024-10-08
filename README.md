# Taql

TODO: Delete this and the text below, and describe your gem

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/taql`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

TODO: Replace `UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG` with your gem name right after releasing it to RubyGems.org. Please do not do it earlier due to security reasons. Alternatively, replace this section with instructions to install your gem from git if you don't plan to release to RubyGems.org.

Install the gem and add to the application's Gemfile by executing:

    $ bundle add UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG

## Usage

```sh
~/Developer/writebook % taql "select id, title, author, slug from books"
+----+----------------------+-----------+----------------------+
| ID | TITLE                | AUTHOR    | SLUG                 |
+----+----------------------+-----------+----------------------+
| 1  | The Writebook Manual | 37signals | the-writebook-manual |
+----+----------------------+-----------+----------------------+
```

```sh
~/Developer/check-in (main) % taql "select id, first_name, last_name, created_at, updated_at from guests limit 3"
+----+------------+------------+-------------------------+-------------------------+
| ID | FIRST_NAME | LAST_NAME  | CREATED_AT              | UPDATED_AT              |
+----+------------+------------+-------------------------+-------------------------+
| 1  | Alejandro  | Bustamante | 2023-07-26 16:26:21 UTC | 2023-07-26 16:26:21 UTC |
| 2  | Reina      | Zelaya     | 2023-07-26 16:26:21 UTC | 2023-07-26 16:26:21 UTC |
| 3  | Carla      | Barrios    | 2023-07-26 16:26:21 UTC | 2023-07-26 16:26:21 UTC |
+----+------------+------------+-------------------------+-------------------------+
```

```sh
~/Developer/check-in (main|!|+) % taql "select count(id) as guest_count from guests"
+-------------+
| GUEST_COUNT |
+-------------+
| 3721        |
+-------------+
```

```ruby
>> Taql.execute('select id, email from users order by created at limit 3').pluck("email")
   (1.2ms)  select id, email from users limit 3
+----+---------------------+
| ID | EMAIL               |
+----+---------------------+
| 1  | alice@example.com   |
| 2  | bob@example.com     |
| 3  | charlie@example.com |
+----+---------------------+
=> ["alice@example.com", "bob@example.com", "charlie@example.com"]
```

```ruby
>> Taql.execute("select * from schema_migrations limit 3")
   (0.7ms)  select * from schema_migrations limit 3
+----------------+
| VERSION        |
+----------------+
| 20240819175830 |
| 20240815131806 |
| 20240815131747 |
+----------------+
=> #<PG::Result:0x000000012ebf6a38 status=PGRES_TUPLES_OK ntuples=3 nfields=1 cmd_tuples=3>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/taql. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/taql/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Taql project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/taql/blob/main/CODE_OF_CONDUCT.md).
