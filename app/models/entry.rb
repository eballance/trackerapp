class Entry < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  validates :date, presence: true
  validates :project, presence: true
  validates :user, presence: true
  validates :minutes, presence: true, numericality: true

  scope :for_user, ->(user) { where(user_id: user.id) }
  scope :for_project, ->(project) { where(project_id: project.id) }
  scope :between, ->(from, to) { where(date: from..to) }
  scope :by_date, -> { order('date asc') }
  scope :by_created_at, -> { order('created_at desc') }

end
