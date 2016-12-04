# frozen_string_literal: true

require "bq_guess/fields"
require "bq_guess/schema"

module BqGuess
  class Guesser
    attr_reader :record

    class << self
      def guess_records(records)
        records[1..-1].each_with_object(guess(records.first)) do |record, schema|
          schema.merge!(guess(record))
        end
      end

      def guess(record)
        new(record).guess
      end
    end

    def initialize(record)
      @record = record
    end

    def guess
      record.each_with_object(Schema.new) do |(key, value), schema|
        schema[key] = guess_field(key, value)
      end
    end

    private

    def guess_field(key, value)
      case value
      when TrueClass, FalseClass
        Fields::Boolean.new(key)
      when Float
        Fields::Float.new(key)
      when Integer
        Fields::Integer.new(key)
      when NilClass
        Fields::Null.new(key)
      when Hash
        Fields::Record.new(key, self.class.guess(value))
      when String
        Fields::String.new(key)
      when Array
        guess_field(key, value.first).tap(&:repeated!)
      end
    end
  end
end
