require 'test_helper'

describe User do
  let(:user){users(:one)}

  it 'has many stars' do
    u = User.reflect_on_association(:stars)
    u.macro.must_equal :has_many, "User does not have many stars"
  end

  it 'has many starred_entries through stars' do
    u = User.reflect_on_association(:starred_entries)
    u.macro.must_equal :has_many, "User does not have many starred entries"
    u.options[:through].must_equal :stars, "User does not have many starred entries through stars"
  end

  it 'returns an entry through starred_entries' do
    user.starred_entries.first.must_equal entries(:entry_one)
  end

end
