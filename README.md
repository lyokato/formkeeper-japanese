# FormKeeper::Japanese

This provides Japanese specific filters and constraints for formkeeper

## Installation

Add this line to your application's Gemfile:

    gem 'formkeeper-japanese'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install formkeeper-japanese

## Usage

### Synopsis

In your sinatra application with sinatra-formkeeper

```ruby
require 'sinatra/formkeeper'
require 'formkeeper/japanese'

post '/entry' do
  form do
    field :yomigana, :present => true, :katakana => true, :length => 0..16 :filters => [:hiragana_to_katakana]
    field :tel, :present => true, :int => true, :filters => [:zenkaku_to_hankaku]
  end
end

```

### Filters

* zenkaku_to_hankaku
* hankaku_to_zenkaku
* hiragana_to_katakana
* katakana_to_hiragana

### Constraints

* kana
* hiragana
* katakana

## See Also

* https://github.com/lyokato/formkeeper
* https://github.com/lyokato/sinatra-formkeeper

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
