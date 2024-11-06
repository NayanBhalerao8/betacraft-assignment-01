# app/views/api/v1/projects/show.json.jbuilder
json.id @project.id
json.name @project.name
json.description @project.description
json.user_id @project.user_id
json.created_at @project.created_at
json.updated_at @project.updated_at

json.tasks @project.tasks, partial: 'tasks/task', as: :task
