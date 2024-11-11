# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  completed   :boolean
#  description :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  project_id  :bigint           not null
#  user_id     :bigint
#
# Indexes
#
#  index_tasks_on_project_id  (project_id)
#  index_tasks_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
class Task < ApplicationRecord
    belongs_to :project
    has_many :comments, dependent: :destroy
    belongs_to :user

    validates :title, presence: true
    validates :description, presence: true

    # Method to initialize a new task within a project and user context
    def self.create_for_project_and_user(project_id, user, params)
      task = new(params.merge(project_id: project_id, user_id: user.id))
      task.save ? task : task
    end

    # Method to find a task by ID within a specific project
    def self.find_in_project(task_id, project_id)
      find_by(id: task_id, project_id: project_id)
    end
    
end
