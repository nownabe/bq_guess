# frozen_string_literal: true

require "bq_guess/fields/base"

module BqGuess
  module Fields
    class Null < Base
      def initialize(name)
        super
        @type = :string
        nullable!
      end
    end
  end
end
