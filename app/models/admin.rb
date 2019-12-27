class Admin < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  has_many :articles

  validates_presence_of :name
end
