class Project < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :publications
  has_many :expenses
  belongs_to :chair
  validates :title, presence: true
end
