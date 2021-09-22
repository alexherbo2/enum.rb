# Enum for Ruby

A [Ruby] implementation of [enumerated type] for educational purposes.

[Ruby]: https://www.ruby-lang.org
[Enumerated type]: https://en.wikipedia.org/wiki/Enumerated_type

Heavily based on [Crystal].

[Crystal]: https://crystal-lang.org

## Overview

An enum is a set of integer values, where each value has an associated name.

For example:

``` ruby
require 'enum'

class Color < Enum
  member :Red # 0
  member :Green # 1
  member :Blue # 2
end
```

Values start with the value `0` and are incremented by one, but can be overwritten.

To get the underlying value you invoke `value` on it:

``` ruby
Color::Green.value # ⇒ 1
```

### Enums from integers

An enum can be created from an integer:

``` ruby
Color.new(1).to_s # ⇒ "Green"
```

Values that don’t correspond to enum’s constants are allowed:
the value will still be of type `Color`, but when printed you will get the underlying value:

``` ruby
Color.new(10).to_s # ⇒ "10"
```

This method is mainly intended to convert integers from C to enums in [Ruby].

### Question methods

``` ruby
Color::Red.red? # ⇒ true
Color::Blue.red? # ⇒ false
```

## Usage

``` ruby
def paint(color)
  case color
  when Color::Red
    # ...
  else
    # Unusual, but still can happen.
    raise "Unknown color: #{color}"
  end
end
```

## Reference

- [Crystal reference]
- [Crystal API]

[Crystal reference]: https://crystal-lang.org/reference/syntax_and_semantics/enum.html
[Crystal API]: https://crystal-lang.org/api/master/Enum.html
