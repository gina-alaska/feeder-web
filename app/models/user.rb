class User < ActiveRecord::Base
  include GinaAuthentication::UserModel

  has_many :stars
  has_many :starred_entries, through: :stars, source: :entry
end
