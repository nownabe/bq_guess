# frozen_string_literal: true

require "json"
require "bq_guess/guessers/json_lines"

module BqGuess
  class Cli
    attr_reader :options

    def initialize(args = [])
      @options = parse_option(args)
    end

    def execute
      result =
        Guessers::JsonLines.new(
          File.read(File.expand_path(options[:input_path]))
        ).guess.as_schema
      puts JSON.pretty_generate(result)
    end

    private

    # TODO: ignore error line
    # TODO: default nullable instead of required
    def parse_option(args)
      if args.include?("-h") || args.include?("--help")
        puts "usage: bq_guess input_file"
        exit
      elsif args.include?("-v") || args.include?("--version")
        require "bq_guess/version"
        puts BqGuess::VERSION
        exit
      else
        { input_path: args.first }
      end
    end
  end
end
