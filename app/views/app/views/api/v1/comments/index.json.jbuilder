# app/views/api/v1/comments/index.json.jbuilder
json.array!(@task.comments) do |comment|
    json.id comment.id
    json.content comment.content
    json.user_name comment.user.name
    json.created_at comment.created_at
    json.updated_at comment.updated_at
  end
  