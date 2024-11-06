# app/views/api/v1/tasks/_task.json.jbuilder
json.id task.id
json.title task.title
json.description task.description
json.completed task.completed

json.comments task.comments, partial: 'comments/comment', as: :comment
