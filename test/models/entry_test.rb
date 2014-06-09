require 'test_helper'

describe Entry do

  let(:entry){entries(:one)}

  it('is valid with valid params') do
    entry.must_be :valid?, "Unable to create Entry with valid parameters"
  end

  it('belongs to a feed') do
    Entry.reflect_on_association(:feed).macro.must_equal :belongs_to, "Entry does not belong to Feed"
  end
end
