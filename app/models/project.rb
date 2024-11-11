# == Schema Information
#
# Table name: projects
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_projects_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Project < ApplicationRecord
    has_many :invites, dependent: :destroy 
    has_many :tasks
    belongs_to :user
    validates :name, presence: true
    validates :description, presence: true

    # Method to include tasks and comments in the JSON response
    def as_json(options = {})
      super(options.merge(include: { tasks: { include: :comments } }))
    end
end
