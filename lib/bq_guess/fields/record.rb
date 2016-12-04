# frozen_string_literal: true

require "bq_guess/fields/base"

module BqGuess
  module Fields
    class Record < Base
      attr_reader :fields

      def initialize(name, fields)
        super(name)
        @fields = fields
      end

      def as_schema
        super.merge(fields: fields.as_schema)
      end

      def to_hash
        super.merge(fields: fields.to_a)
      end
    end
  end
end
