# frozen_string_literal: true

require_relative "./dsl/contract"

module ActionControllerTyped
  module DSL
    module ClassMethods
      def contract(&block)
        @contract_block = block
      end

      def contracts
        @contracts ||= {}
      end

      def method_added(action)
        if block = @contract_block
          instance = Contract.new(controller: self, action:)
          instance.instance_eval(&block)
          contracts[action] = instance
          @contract_block = nil
        end
      end
    end

    module InstanceMethods
      def contract_for(name)
        self.class.contracts[name]
      end
    end

    def self.included(base)
      base.extend ClassMethods
      base.include InstanceMethods
    end
  end
end
