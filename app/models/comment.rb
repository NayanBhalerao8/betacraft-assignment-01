# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  task_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_task_id  (task_id)
#  index_comments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (task_id => tasks.id)
#  fk_rails_...  (user_id => users.id)
#
class Comment < ApplicationRecord
    belongs_to :task
    belongs_to :user
  
    validates :content, presence: true
    validates :user_id, presence: true

    def self.create_for_task(task, user, content)
        comment = task.comments.new(content: content, user: user)
        comment.save
        comment
    end
end
  
