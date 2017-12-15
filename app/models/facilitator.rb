class Facilitator < ApplicationRecord

  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable,
         :invitable, invite_for: 2.weeks, validate_on_invite: true

  has_many :projects

  validates :email, presence: true, format: { with: /\A[\w.!#$%&’*+\/=?^`{|}~-]+@[\w-]+(?:\.[\w-]+)+\z/ }
  validates :full_name, presence: true
  validates :school, presence: true
  validates :district, presence: true
  enum state: [:johor, :kedah, :kelantan, :kuala_lumpur, :labuan, :melaka, :negeri_sembilan, :pahang, :perak, :perlis, :penang, :putrajaya, :sabah, :sarawak, :selangor, :terengganu]
  validates :phone_number, presence: true, numericality: { only_integer: true }

end
