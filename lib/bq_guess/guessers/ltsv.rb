# frozen_string_literal: true

require "bq_guess/guessers/base"

module BqGuess
  module Guessers
    class Ltsv < Base
      private

      def parse_line(line)
        line.split("\t").each_with_object({}) do |kv, h|
          next unless kv.include?(":")
          key, value = kv.split(":", 2)
          h[key] = value.empty? ? nil : value
        end
      end

      def records
        file_content.lines.map { |l| parse_line(l) }
      end
    end
  end
end
