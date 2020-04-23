class User < ApplicationRecord
  acts_as_token_authenticatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates_presence_of :kind
  has_many :training_routines
  enum kind: {
    user: 1,
    admin: 2
  }
end
