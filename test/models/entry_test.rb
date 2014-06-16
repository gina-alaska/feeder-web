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

  it('has a source_url') do
    entry.source_url = nil
    entry.valid?.must_equal false
  end

  #TODO: This is a bad name
  it('can be starred by users') do
    entry.starred?(users(:one)).must_equal true, "Entry should be starred by user"
    entry.starred?(User.new).must_equal false, "Entry should not be starred by user"
  end
end
