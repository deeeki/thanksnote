class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :image, type: String
  field :email, type: String
  field :token, type: String
  has_and_belongs_to_many :friends, class_name: 'User'

  class << self
    def from_omniauth auth
      if user = User.find_by(id: auth.uid)
        unless user.email?
          user.update_attributes({
            email: auth.info.email,
            token: auth.credentials.token,
          })
        end
        user
      else
        User.create({
          id: auth.uid,
          name: auth.info.name,
          image: auth.info.image,
          email: auth.info.email,
          token: auth.credentials.token,
        })
      end
    end
  end

  def client
    @client ||= FbGraph::User.me(token)
  end

  def register_friends
    friend_ids = []
    client.friends.each do |friend|
      friend_ids << friend.identifier
      next if User.find_by(id: friend.identifier)
      User.create({
        id: friend.identifier,
        name: friend.name,
        image: "http://graph.facebook.com/#{friend.identifier}/picture?type=square",
      })
    end
    update_attribute(:friend_ids, friend_ids)
  end
end
