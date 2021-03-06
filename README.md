# RuboCop Cask

[![Gem Version](https://badge.fury.io/rb/rubocop-cask.svg)](http://badge.fury.io/rb/rubocop-cask)
[![Build Status](https://travis-ci.org/Homebrew/rubocop-cask.svg?branch=master)](https://travis-ci.org/Homebrew/rubocop-cask)
[![Test Coverage](https://api.codeclimate.com/v1/badges/977ef213ba6fb6c08022/test_coverage)](https://codeclimate.com/github/Homebrew/rubocop-cask/test_coverage)
[![Maintainability](https://api.codeclimate.com/v1/badges/977ef213ba6fb6c08022/maintainability)](https://codeclimate.com/github/Homebrew/rubocop-cask/maintainability)

Cask-specific analysis for your [Homebrew-Cask](https://github.com/Homebrew/homebrew-cask) taps, as an extension to
[RuboCop](https://github.com/bbatsov/rubocop). Heavily inspired by [`rubocop-rspec`](https://github.com/rubocop-rspec/rubocop-rspec).

## Installation

Just install the `rubocop-cask` gem

```bash
gem install rubocop-cask
```

or if you use bundler put this in your `Gemfile`

```ruby
gem 'rubocop-cask'
```


## Usage

You need to tell RuboCop to load the Cask extension. There are three ways to do this:

### RuboCop configuration file

Put this into your `.rubocop.yml`:

```yaml
require: rubocop-cask
```

Now you can run `rubocop` and it will automatically load the RuboCop Cask cops together with the standard cops.

### Command line

```bash
rubocop --require rubocop-cask
```

### Rake task

```ruby
RuboCop::RakeTask.new do |task|
  task.requires << 'rubocop-cask'
end
```


## The Cops

All cops are located under [`lib/rubocop/cop/cask`](lib/rubocop/cop/cask), and contain examples/documentation.

In your `.rubocop.yml`, you may treat the Cask cops just like any other cop. For example:

```yaml
Cask/NoDslVersion:
  Enabled: false
```


## Contributing

1. Fork it.
2. Create your feature branch (`git checkout -b my-new-feature`).
3. Commit your changes (`git commit -am 'Add some feature'`).
4. Push to the branch (`git push origin my-new-feature`).
5. Create new pull request.


## Maintaining

To publish a new release:

  1. Update the version in `lib/rubocop/cask/version.rb`.
  2. Run `bundle exec rake build` to run tests and generate the changelog.
  3. Commit the changes.
  4. Create a new tag on GitHub.


## License

`rubocop-cask` is MIT licensed. [See the accompanying file](MIT-LICENSE.md) for
the full text.
