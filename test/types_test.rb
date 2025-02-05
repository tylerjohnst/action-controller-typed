# frozen_string_literal: true

require "test_helper"

class MockDictionaryType < ActionControllerTyped::Types::Dictionary
  field :name, type: :string
  field :age, type: :integer
  field :confidence, type: :number
  field :is_cool, type: :boolean
end

class MockReferenceType < ActionControllerTyped::Types::Dictionary
  field :person, type: MockDictionaryType
  field :tags, type: [:string]
end

describe ActionControllerTyped::Types do
  it "supports arbitrary key value dictionary" do
    assert_equal :string, MockDictionaryType.fields[:name].type
    assert_equal :integer, MockDictionaryType.fields[:age].type
    assert_equal :number, MockDictionaryType.fields[:confidence].type
    assert_equal :boolean, MockDictionaryType.fields[:is_cool].type
  end

  it "supports collection types" do
    field = MockReferenceType.fields[:tags].type
    assert_instance_of ActionControllerTyped::Types::Collection, field
    assert_equal :string, field.inner_type
  end

  it "supports references to other dictionary types" do
    assert_equal MockDictionaryType, MockReferenceType.fields[:person].type
  end

  it "throws errors when defining a field of an ineligible type" do
    begin
      Class.new(ActionControllerTyped::Types::Dictionary) do
        field :invalid, type: :circle
      end
    rescue => exception
    end

    refute_nil exception
  end

  it "throws errors when defining a field of an ineligible type" do
    begin
      Class.new(ActionControllerTyped::Types::Dictionary) do
        field :invalid, type: [String]
      end
    rescue => exception
    end

    refute_nil exception
  end
end
