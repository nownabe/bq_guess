# frozen_string_literal: true

require "json"
require "bq_guess/guessers/base"

module BqGuess
  module Guessers
    class JsonLines < Base
      private

      def records
        file_content.lines.map { |l| JSON.parse(l) }
      end
    end
  end
end
