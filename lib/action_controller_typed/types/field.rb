# frozen_string_literal: true

require_relative "collection"

module ActionControllerTyped
  module Types
    class Field
      Unsupported = Class.new(StandardError)

      PRIMITIVES = %i(string number integer boolean)

      attr_reader :name
      attr_reader :type

      def initialize(name, type:)
        @name = name
        @type = parse(type)
      end

      private

      def parse(type)
        return type if PRIMITIVES.include?(type)
        return type if type.respond_to?(:ancestors) && type.ancestors.include?(Dictionary)
        return type if type.is_a?(Dictionary)

        if type.is_a?(Array) && type.length == 1
          return Collection.new(parse(type.first))
        end

        raise Unsupported, "unsupported type: #{type.inspect}"
      end
    end
  end
end
