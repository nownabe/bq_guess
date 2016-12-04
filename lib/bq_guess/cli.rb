# frozen_string_literal: true

require "json"
require "bq_guess/guessers/json_lines"
require "bq_guess/guessers/ltsv"

module BqGuess
  class Cli
    attr_reader :options

    def initialize(args = [])
      @options = parse_option(args)
    end

    def execute
      puts JSON.pretty_generate(guesser.guess.as_schema)
    end

    private

    def format
      JSON.parse(input_content.lines.first)
      :json_lines
    rescue
      :ltsv
    end

    def guesser
      case format
      when :json_lines
        Guessers::JsonLines.new(input_content)
      when :ltsv
        Guessers::Ltsv.new(input_content)
      end
    end

    def input_content
      @input_content ||= File.read(File.expand_path(options[:input_path]))
    end

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
