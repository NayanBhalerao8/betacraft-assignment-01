# app/views/api/v1/tasks/update.json.jbuilder
json.id @task.id
json.title @task.title
json.description @task.description
json.completed @task.completed
json.project_id @task.project_id
json.user_id @task.user_id
