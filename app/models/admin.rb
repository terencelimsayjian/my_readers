class Admin < ApplicationRecord
  devise :database_authenticatable, :trackable, :authentication_keys => [:username]
  include DeviseInvitable::Inviter
end
