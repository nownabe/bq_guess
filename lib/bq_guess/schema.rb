# frozen_string_literal: true

require "bq_guess/fields"

module BqGuess
  class Schema < Hash
    def as_schema
      values.map(&:as_schema)
    end

    def merge!(other)
      _merge!(other)
      set_nullable(other)
    end

    def null?(key)
      !key?(key) || self[key].is_a?(Fields::Null)
    end

    def nullable!
      each_value(&:nullable!)
    end

    def repeated?(key)
      !!self[key]&.repeated?
    end

    def to_a
      values.map(&:to_hash)
    end

    private

    def _merge!(other)
      each do |key, field|
        if other.null?(key)
          field.nullable! unless other.repeated?(key)
        else
          if field.is_a?(Fields::Null)
            self[key] = other[key]
            self[key].nullable! unless other.repeated?(key)
          end
          if field.is_a?(Fields::Record) && other[key].is_a?(Fields::Record)
            self[key].fields.merge!(other[key].fields)
          end
        end
      end
    end

    def set_nullable(other)
      (other.keys - keys).each do |key|
        self[key] = other[key]
        self[key].nullable!
      end
    end
  end
end
