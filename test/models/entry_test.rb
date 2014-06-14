require 'test_helper'

describe Entry do

  let(:entry){entries(:one)}

  it('is valid with valid params') do
    entry.must_be :valid?, "Unable to create Entry with valid parameters"
  end

  it('belongs to a feed') do
    Entry.reflect_on_association(:feed).macro.must_equal :belongs_to, "Entry does not belong to Feed"
  end

  it('has many stars') do
    e = Entry.reflect_on_association(:stars)
    e.macro.must_equal :has_many, "Entry does not have many Stars"
  end

  it('has many users through stars') do
    e = Entry.reflect_on_association(:users)
    e.macro.must_equal :has_many, "Entry does not have many users"
    e.options[:through].must_equal :stars, "Entry does not have many users through stars"
  end
end
