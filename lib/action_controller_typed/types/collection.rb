# frozen_string_literal: true

module ActionControllerTyped
  module Types
    class Collection
      attr_reader :inner_type

      def initialize(inner_type)
        @inner_type = inner_type
      end

      def type = :array
    end
  end
end
