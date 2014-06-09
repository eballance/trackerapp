class Project < ActiveRecord::Base

  has_many :entries
  has_many :project_users
  has_many :users, :through => :project_users
  belongs_to :account

  validates :name, :presence => true, :allow_nil => false
  validate :account_id, presence: true
end
