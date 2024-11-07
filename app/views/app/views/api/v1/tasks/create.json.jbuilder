# app/views/api/v1/tasks/create.json.jbuilder
json.id @task.id
json.title @task.title
json.completed @task.completed
json.user do
  json.name @task.user.name
  json.email @task.user.email
end
