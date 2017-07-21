class Facilitator < ApplicationRecord
  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable,
         :invitable, invite_for: 2.weeks
end
