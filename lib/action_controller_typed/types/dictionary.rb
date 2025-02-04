# frozen_string_literal: true

module ActionControllerTyped
  module DSL
    class Dictionary
      class Field
        attr_reader :name
        attr_reader :type

        def initialize(name, type:)
          @name = name
          @type = type
        end
      end

      attr_reader :name

      def self.build(name:, &block)
        instance = new(name:)
        instance.instance_eval(&block)
        instance
      end

      def initialize(name:)
        @name = name
        @fields = {}
      end

      def [](name)
        @fields[name]
      end

      def field(name, type:)
        @fields[name] = Field.new(name, type: type)
      end
    end
  end
end
