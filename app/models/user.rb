class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :email, type: String
  field :token, type: String
  field :image, type: String
  has_and_belongs_to_many :friends, class_name: 'User'
end
