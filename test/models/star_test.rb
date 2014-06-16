require 'test_helper'

describe Star do

  it 'belongs to an entry' do
    s = Star.reflect_on_association(:entry)
    s.macro.must_equal :belongs_to, "Star does not belong to an Entry"
  end

  it 'belongs to a user' do
    s = Star.reflect_on_association(:user)
    s.macro.must_equal :belongs_to, "Star does not belong to a User"
  end
end
