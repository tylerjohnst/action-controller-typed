# frozen_string_literal: true

require_relative "../types/dictionary"

module ActionControllerTyped
  module DSL
    class Contract
      attr_reader :controller
      attr_reader :action
      attr_reader :params_type
      attr_reader :returns_type

      def initialize(controller:, action:)
        @controller = controller
        @action = action
        @params_type = nil
        @returns_type = nil
      end

      def params(type: nil, name: "#{@controller}Params", &block)
        if type
          @params_type = type
        else
          @params_type = Dictionary.build(name:, &block)
        end
      end

      def returns(type: nil, name: "#{@controller}Returns", &block)
        if type
          @returns_type = type
        else
          @returns_type = Dictionary.build(name:, &block)
        end
      end
    end
  end
end
