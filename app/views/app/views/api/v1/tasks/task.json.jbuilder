json.id task.id
json.title task.title
json.completed task.completed
json.created_at task.created_at
json.updated_at task.updated_at

json.comments task.comments do |comment|
  json.partial! 'api/v1/comments/comment', comment: comment
end