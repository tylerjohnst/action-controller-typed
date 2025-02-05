# frozen_string_literal: true

require "test_helper"

class MockController
  include ActionControllerTyped::DSL

  contract {
    params do
      field :first_name, type: :string
    end

    returns do
      field :id, type: :integer
      field :first_name, type: :string
    end
  }
  def show
    # ...
  end
end

describe ActionControllerTyped::DSL do
  it "has a contract for the show action" do
    controller = MockController.new
    contract = controller.contract_for(:show)

    assert_equal MockController, contract.controller
    assert_equal :show, contract.action

    params = contract.params_type
    assert_equal "MockControllerParams", params.name
    assert_equal :string, params.fields[:first_name].type

    returns = contract.returns_type
    assert_equal "MockControllerReturns", returns.name
    assert_equal :integer, returns.fields[:id].type
    assert_equal :string, returns.fields[:first_name].type
  end
end
