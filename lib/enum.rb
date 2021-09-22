require 'rails'

class Enum
  include Comparable

  # Attributes
  attr_reader :value

  # Creates a new instance.
  # @param {Integer} value
  def initialize(value)
    @value = value
  end

  # Creates a new member.
  # @param {Symbol | String} name
  # @param {Integer} value
  def self.member(name, value = constants.size)
    enum = new(value)
    const_set(name, enum)
    define_method("#{name.to_s.underscore}?") do
      self == enum
    end
  end

  # Returns all enum members as an `Array(String)`.
  # @returns Array(String)
  def self.names
    constants.map(&:to_s)
  end

  # Returns all enum members as an `Array(self)`.
  # @returns Array(Enum)
  def self.values
    constants.map do |constant|
      const_get(constant)
    end
  end

  # Compares this enum member against another, according to their underlying value.
  # @param {Enum} other
  def <=>(other)
    value <=> other.value
  end

  # Returns the enum member that has the given `name`, or raises an exception if no such member exists.
  # @param {Symbol | String} name
  # @returns {Enum | Exception}
  def self.parse(name)
    parse?(name) or raise "Unknown enum #{self} value: #{name}"
  end

  # Returns the enum member that has the given `name`, or `nil` if no such member exists.
  # @param {Symbol | String} name
  # @returns {Enum | Nil}
  def self.parse?(name)
    parser = constants.lazy.map do |constant|
      if constant.to_s.underscore == name.to_s.underscore
        const_get(constant)
      end
    end

    parser.find(&:itself)
  end

  # Returns the value of this enum member as an `Integer`.
  # @returns {Integer}
  def to_i
    value.to_i
  end

  # Returns a `String` representation of this enum member.
  # In the case of regular enums, this is just the name of the member.
  # If an enum’s value doesn’t match a member’s value, the raw value is returned as a string.
  # @returns {String}
  def to_s
    parser = self.class.constants.lazy.map do |constant|
      if self.class.const_get(constant) == self
        constant.to_s
      end
    end

    parser.find(&:itself) or value.to_s
  end
end
