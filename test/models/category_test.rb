require 'test_helper'

describe Category do
  let(:category){categories(:one)}

  it 'has many feeds' do
    c = Category.reflect_on_association(:feeds)
    c.macro.must_equal :has_many, "Category does not have many feeds"
  end


  describe 'validations' do
    let(:category){categories(:one)}
    it 'is invalid without a name' do
      category.name = nil
      category.wont_be :valid?, "category valid without name"
    end

    it 'is invalid with an empty name' do
      category.name = ""
      category.wont_be :valid?, "category valid with blank name"
    end
  end

end
