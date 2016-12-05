# BqGuess
[![Gem Version](https://badge.fury.io/rb/bq_guess.svg)](https://badge.fury.io/rb/bq_guess)
[![Code Climate](https://codeclimate.com/repos/58451c2e5a93d470e4000449/badges/ee7d46fb6251050c7493/gpa.svg)](https://codeclimate.com/repos/58451c2e5a93d470e4000449/feed)
[![Test Coverage](https://codeclimate.com/repos/58451c2e5a93d470e4000449/badges/ee7d46fb6251050c7493/coverage.svg)](https://codeclimate.com/repos/58451c2e5a93d470e4000449/coverage)
[![Issue Count](https://codeclimate.com/repos/58451c2e5a93d470e4000449/badges/ee7d46fb6251050c7493/issue_count.svg)](https://codeclimate.com/repos/58451c2e5a93d470e4000449/feed)

BqGuess guesses BigQuery schema from existing logs.

## Installation
```bash
$ gem install bq_guess
```

## Usage
```bash
$ bq_guess existing_log.jsonl
```

For example:

```bash
$ cat existing_log.jsonl
{"required":123,"optional":true,"nested":{"required":1234,"optional":"yes"},"array":[0,1,2,3,4]}
{"required":456,"optional":false,"nested":{"required":1234,"optional":"yes","nested":{"prop":1}},"array":[5,6,7,8,9]}
{"required":789,"nested":{"required":1234,"optional":"yes","additional":"added"},"array":[]}

$ bq_guess existing_log.jsonl
[
  {
    "name": "required",
    "type": "INTEGER",
    "mode": "REQUIRED"
  },
  {
    "name": "optional",
    "type": "BOOLEAN",
    "mode": "NULLABLE"
  },
  {
    "name": "nested",
    "type": "RECORD",
    "mode": "REQUIRED",
    "fields": [
      {
        "name": "required",
        "type": "INTEGER",
        "mode": "REQUIRED"
      },
      {
        "name": "optional",
        "type": "STRING",
        "mode": "REQUIRED"
      },
      {
        "name": "nested",
        "type": "RECORD",
        "mode": "NULLABLE",
        "fields": [
          {
            "name": "prop",
            "type": "INTEGER",
            "mode": "REQUIRED"
          }
        ]
      },
      {
        "name": "additional",
        "type": "STRING",
        "mode": "NULLABLE"
      }
    ]
  },
  {
    "name": "array",
    "type": "INTEGER",
    "mode": "REPEATED"
  }
]
```

## Supported Formats
* JSON Lines
* LTSV

## Development
After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/nownabe/bq_guess.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
