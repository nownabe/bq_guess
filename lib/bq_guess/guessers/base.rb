# frozen_string_literal: true

require "bq_guess/guesser"

module BqGuess
  module Guessers
    class Base
      attr_reader :file_content

      def initialize(file_content)
        @file_content = file_content
      end

      def guess
        BqGuess::Guesser.guess_records(records)
      end
    end
  end
end
