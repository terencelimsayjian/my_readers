class Admin < ApplicationRecord

  devise :database_authenticatable, :trackable, :rememberable, authentication_keys: [:username]
  include DeviseInvitable::Inviter

end
