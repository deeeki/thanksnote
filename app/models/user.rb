class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :email, type: String
  field :token, type: String
  field :image, type: String
  has_and_belongs_to_many :friends, class_name: 'User'

  class << self
    def from_omniauth auth
      user = User.find_by(id: auth.uid)
      return user if user
      User.create({
        name: auth.info.name,
        email: auth.info.email,
        id: auth.uid,
        token: auth.credentials.token,
        image: auth.info.image,
      })
    end
  end
end
