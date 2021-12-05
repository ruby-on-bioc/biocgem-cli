# frozen_string_literal: true

require "test_helper"

class BiocGemTest < Test::Unit::TestCase
  test "VERSION" do
    assert do
      ::BiocGem.const_defined?(:VERSION)
    end
  end
end
