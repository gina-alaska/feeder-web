require 'test_helper'

class HighlightTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @highlight = highlights(:one)
  end
  
  test "highlight without description should be invalide" do
    @highlight.description = nil
    assert !@highlight.valid?
  end
end
