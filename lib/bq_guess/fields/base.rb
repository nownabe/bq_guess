# frozen_string_literal: true

module BqGuess
  module Fields
    class Base
      attr_reader :name, :mode, :type

      def initialize(name)
        @name = name
        @type = self.class.to_s.split("::").last.downcase.to_sym
        required!
      end

      def as_schema
        {
          name: name,
          type: type.to_s.upcase,
          mode: mode.to_s.upcase
        }
      end

      def nullable!
        @mode = :nullable
      end

      def nullable?
        mode == :nullable
      end

      def repeated!
        @mode = :repeated
      end

      def repeated?
        mode == :repeated
      end

      def required!
        @mode = :required
      end

      def required?
        mode == :required
      end

      def to_hash
        {
          name: name,
          type: type,
          mode: mode
        }
      end
    end
  end
end
