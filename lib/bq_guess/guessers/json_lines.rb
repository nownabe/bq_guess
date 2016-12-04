# frozen_string_literal: true

require "json"
require "bq_guess/guesser"
require "bq_guess/schema"

module BqGuess
  module Guessers
    class JsonLines
      attr_reader :json_lines

      def initialize(json_lines)
        @json_lines = json_lines.lines
      end

      def guess
        BqGuess::Guesser.guess_records(
          json_lines.map { |l| JSON.parse(l) }
        )
      end
    end
  end
end
