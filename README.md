# Modulla

Modulla is a super simple gem to enable DSL on your module.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'modulla'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install modulla

## Usage

```ruby
module DSL
  extend Modulla

  foo { 'foo' }
  bar { 'bar' }
  baz { 'baz' }

  plus(1, 1)
end

class Sample
  def self.foo(&block)
    puts block.call * 1
  end

  def self.bar(&block)
    puts block.call * 2
  end

  def self.baz(&block)
    puts block.call * 3
  end

  def self.plus(a, b)
    puts a + b
  end
end

class Sample
  include DSL #=> Output: 'foo', 'barbar', 'bazbazbaz', 2
end
```

You can use modulla for use shared_examples in test-unit like this.

```ruby
module SharedExamplesForFoo
  extend Modulla

  sub_test_case 'foo' do
    test 'yay' do
      assert { ... }
    end
  end
end

class Testing < Test::Unit::TestCase
  include SharedExamplesForFoo
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/namusyaka/modulla.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

