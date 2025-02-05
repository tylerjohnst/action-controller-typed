# frozen_string_literal: true

require_relative "field"

module ActionControllerTyped
  module Types
    class Dictionary
      def self.field(name, type:)
        fields[name] = Field.new(name, type:)
      end

      def self.fields
        @fields ||= {}
      end

      attr_reader :name

      def self.build(name:, &block)
        klass = Class.new(self, &block)
        klass.define_singleton_method(:name) { name }
        klass
      end

      def initialize(name:)
        @name = name
      end

      def fields
        self.class.fields
      end
    end
  end
end
