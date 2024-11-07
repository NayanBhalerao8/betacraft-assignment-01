class Comment < ApplicationRecord
    belongs_to :task
    belongs_to :user
  
    validates :content, presence: true
    validates :user_id, presence: true
end
  